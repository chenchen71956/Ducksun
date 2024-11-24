using System.Collections.Generic;
using System.Threading.Tasks;
using Dapper;
using MySql.Data.MySqlClient;
using DuckSun.Models;

namespace DuckSun.Services
{
    public class DatabaseService
    {
        private readonly string _connectionString;
        
        public DatabaseService(DatabaseConfig config)
        {
            _connectionString = config.GetConnectionString();
        }

        public async Task EnsureTablesExistAsync()
        {
            using var connection = new MySqlConnection(_connectionString);
            const string checkTablesSql = @"
                SELECT COUNT(*) 
                FROM information_schema.tables 
                WHERE table_schema = DATABASE() 
                AND table_name IN ('td_question_score_rule', 'td_answer_score', 'td_answer_total_score')";

            var tableCount = await connection.ExecuteScalarAsync<int>(checkTablesSql);
            if (tableCount < 3)
            {
                const string createTablesSql = @"
                    -- 创建评分规则表
                    CREATE TABLE IF NOT EXISTS td_question_score_rule (
                        id BIGINT NOT NULL AUTO_INCREMENT,
                        form_key VARCHAR(100) NOT NULL COMMENT '问卷key',
                        form_item_id VARCHAR(50) NOT NULL COMMENT '题目ID',
                        score DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT '分值',
                        correct_answer TEXT COMMENT '正确答案',
                        create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                        update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                        PRIMARY KEY (id),
                        UNIQUE KEY `uk_form_item` (form_key, form_item_id)
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='题目评分规则';

                    -- 创建答题评分表
                    CREATE TABLE IF NOT EXISTS td_answer_score (
                        id BIGINT NOT NULL AUTO_INCREMENT,
                        form_key VARCHAR(100) NOT NULL COMMENT '问卷key',
                        form_data_id BIGINT NOT NULL COMMENT '答题数据ID',
                        form_item_id VARCHAR(50) NOT NULL COMMENT '题目ID',
                        score DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT '得分',
                        create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                        update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                        PRIMARY KEY (id),
                        UNIQUE KEY `uk_answer_item` (form_key, form_data_id, form_item_id)
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='答题评分';

                    -- 创建答题总分表
                    CREATE TABLE IF NOT EXISTS td_answer_total_score (
                        id BIGINT NOT NULL AUTO_INCREMENT,
                        form_key VARCHAR(100) NOT NULL COMMENT '问卷key',
                        form_data_id BIGINT NOT NULL COMMENT '答题数据ID',
                        total_score DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT '总分',
                        is_pass TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否及格',
                        create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                        update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                        PRIMARY KEY (id),
                        UNIQUE KEY `uk_form_data` (form_key, form_data_id)
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='答题总分';";

                await connection.ExecuteAsync(createTablesSql);
            }
        }

        public async Task<List<Questionnaire>> GetQuestionnairesAsync()
        {
            using var connection = new MySqlConnection(_connectionString);
            const string sql = @"
                SELECT 
                    id as Id,
                    form_key as FormKey,
                    REPLACE(REPLACE(name, '<h2 style=""text-align: center;"">', ''), '</h2>', '') as Title,
                    create_time as CreateTime,
                    status as Status,
                    source_type as SourceType,
                    source_id as SourceId,
                    user_id as UserId,
                    is_deleted as IsDeleted
                FROM fm_user_form
                WHERE is_deleted = 0
                ORDER BY create_time DESC";
            
            return (await connection.QueryAsync<Questionnaire>(sql)).ToList();
        }
        
        public async Task<int> GetAnswerCountAsync(long questionnaireId)
        {
            using var connection = new MySqlConnection(_connectionString);
            const string sql = @"
                SELECT COUNT(*) 
                FROM fm_user_form_data 
                WHERE form_key = (
                    SELECT form_key 
                    FROM fm_user_form 
                    WHERE id = @QuestionnaireId
                )";
            return await connection.ExecuteScalarAsync<int>(sql, new { QuestionnaireId = questionnaireId });
        }

        public async Task<List<QuestionItem>> GetQuestionItemsAsync(long formId)
        {
            await EnsureTablesExistAsync();
            using var connection = new MySqlConnection(_connectionString);
            var formKey = await connection.QueryFirstOrDefaultAsync<string>(
                "SELECT form_key FROM fm_user_form WHERE id = @FormId", 
                new { FormId = formId });

            if (string.IsNullOrEmpty(formKey))
            {
                return new List<QuestionItem>();
            }

            const string sql = @"
                SELECT 
                    id as Id,
                    form_key as FormKey,
                    form_item_id as FormItemId,
                    type as Type,
                    label as Label,
                    show_label as ShowLabel,
                    default_value as DefaultValue,
                    required as Required,
                    sort as Sort,
                    scheme as Extra
                FROM fm_user_form_item 
                WHERE form_key = @FormKey
                ORDER BY sort";
            
            var questions = await connection.QueryAsync<QuestionItem>(sql, new { FormKey = formKey });
            
            const string rulesSql = @"
                SELECT form_item_id, score, correct_answer 
                FROM td_question_score_rule 
                WHERE form_key = @FormKey";
                
            var rules = await connection.QueryAsync<(string FormItemId, double Score, string Answer)>(
                rulesSql, new { FormKey = formKey });
                
            var ruleDict = rules.ToDictionary(r => r.FormItemId);
                
            foreach (var question in questions)
            {
                if (ruleDict.TryGetValue(question.FormItemId, out var rule))
                {
                    question.Score = rule.Score;
                    question.CorrectAnswer = rule.Answer;
                }
            }
            
            return questions.ToList();
        }

        public async Task<List<FormData>> GetFormDataAsync(long formId)
        {
            using var connection = new MySqlConnection(_connectionString);
            var formKey = await connection.QueryFirstOrDefaultAsync<string>(
                "SELECT form_key FROM fm_user_form WHERE id = @FormId", 
                new { FormId = formId });

            if (string.IsNullOrEmpty(formKey))
            {
                return new List<FormData>();
            }

            const string sql = @"
                SELECT 
                    id as Id,
                    form_key as FormKey,
                    original_data as SubmitData,
                    create_time as CreateTime,
                    serial_number as SubmitStatus
                FROM fm_user_form_data
                WHERE form_key = @FormKey
                ORDER BY create_time DESC";
            
            return (await connection.QueryAsync<FormData>(sql, new { FormKey = formKey })).ToList();
        }

        public async Task SaveScoreAsync(long answerId, double totalScore, Dictionary<long, double> questionScores)
        {
            using var connection = new MySqlConnection(_connectionString);
            await connection.OpenAsync();
            using var transaction = connection.BeginTransaction();

            try
            {
                const string updateTotalScore = @"
                    UPDATE td_form_fill 
                    SET total_score = @TotalScore, 
                        is_scored = 1 
                    WHERE id = @AnswerId";
                
                await connection.ExecuteAsync(updateTotalScore, 
                    new { AnswerId = answerId, TotalScore = totalScore }, 
                    transaction);

                const string updateQuestionScore = @"
                    INSERT INTO td_answer_score (answer_id, question_id, score) 
                    VALUES (@AnswerId, @QuestionId, @Score)
                    ON DUPLICATE KEY UPDATE score = @Score";
                
                foreach (var score in questionScores)
                {
                    await connection.ExecuteAsync(updateQuestionScore, 
                        new { AnswerId = answerId, QuestionId = score.Key, Score = score.Value }, 
                        transaction);
                }

                transaction.Commit();
            }
            catch
            {
                transaction.Rollback();
                throw;
            }
        }

        public async Task<QuestionnaireStatistics> GetQuestionnaireStatisticsAsync(long formId)
        {
            using var connection = new MySqlConnection(_connectionString);
            const string sql = @"
                SELECT 
                    COUNT(*) as TotalCount,
                    SUM(CASE WHEN is_scored = 1 THEN 1 ELSE 0 END) as ScoredCount,
                    AVG(CASE WHEN is_scored = 1 THEN total_score ELSE NULL END) as AverageScore,
                    SUM(CASE WHEN is_scored = 1 AND total_score >= 60 THEN 1 ELSE 0 END) * 1.0 / 
                    SUM(CASE WHEN is_scored = 1 THEN 1 ELSE 0 END) as PassRate
                FROM td_form_fill
                WHERE form_id = @FormId";
            
            return await connection.QueryFirstOrDefaultAsync<QuestionnaireStatistics>(sql, new { FormId = formId });
        }

        public async Task TestConnectionAsync()
        {
            using var connection = new MySqlConnection(_connectionString);
            try
            {
                await connection.OpenAsync();
                
                try
                {
                    await connection.ExecuteScalarAsync<int>("SELECT 1");
                }
                catch (MySqlException ex)
                {
                    throw new Exception($"数据库查询失败: {ex.Message}\nErrorCode: {ex.Number}", ex);
                }
            }
            catch (MySqlException ex)
            {
                throw new Exception($"数据库连接失败: {ex.Message}\nErrorCode: {ex.Number}", ex);
            }
            catch (Exception ex)
            {
                throw new Exception($"未知错误: {ex.Message}", ex);
            }
        }

        public async Task SaveScoreRuleAsync(string formKey, string formItemId, double score, string correctAnswer)
        {
            await EnsureTablesExistAsync();
            using var connection = new MySqlConnection(_connectionString);
            const string sql = @"
                INSERT INTO td_question_score_rule (form_key, form_item_id, score, correct_answer)
                VALUES (@FormKey, @FormItemId, @Score, @CorrectAnswer)
                ON DUPLICATE KEY UPDATE 
                    score = @Score,
                    correct_answer = @CorrectAnswer";
            
            await connection.ExecuteAsync(sql, new { 
                FormKey = formKey, 
                FormItemId = formItemId, 
                Score = score, 
                CorrectAnswer = correctAnswer 
            });
        }

        public async Task<Dictionary<string, (double Score, string Answer)>> GetScoreRulesAsync(string formKey)
        {
            await EnsureTablesExistAsync();
            using var connection = new MySqlConnection(_connectionString);
            const string sql = @"
                SELECT form_item_id, score, correct_answer 
                FROM td_question_score_rule 
                WHERE form_key = @FormKey";
            
            var rules = await connection.QueryAsync<(string FormItemId, double Score, string Answer)>(
                sql, new { FormKey = formKey });
            return rules.ToDictionary(r => r.FormItemId, r => (r.Score, r.Answer));
        }

        public async Task SaveAnswerScoreAsync(string formKey, long formDataId, Dictionary<string, double> scores)
        {
            await EnsureTablesExistAsync();
            using var connection = new MySqlConnection(_connectionString);
            await connection.OpenAsync();
            using var transaction = connection.BeginTransaction();

            try
            {
                const string scoreSQL = @"
                    INSERT INTO td_answer_score (form_key, form_data_id, form_item_id, score)
                    VALUES (@FormKey, @FormDataId, @FormItemId, @Score)
                    ON DUPLICATE KEY UPDATE score = @Score";

                foreach (var score in scores)
                {
                    await connection.ExecuteAsync(scoreSQL, new { 
                        FormKey = formKey,
                        FormDataId = formDataId,
                        FormItemId = score.Key,
                        Score = score.Value
                    }, transaction);
                }

                double totalScore = scores.Values.Sum();
                const string totalScoreSQL = @"
                    INSERT INTO td_answer_total_score (form_key, form_data_id, total_score, is_pass)
                    VALUES (@FormKey, @FormDataId, @TotalScore, @IsPass)
                    ON DUPLICATE KEY UPDATE 
                        total_score = @TotalScore,
                        is_pass = @IsPass";

                await connection.ExecuteAsync(totalScoreSQL, new { 
                    FormKey = formKey,
                    FormDataId = formDataId,
                    TotalScore = totalScore,
                    IsPass = totalScore >= 60
                }, transaction);

                transaction.Commit();
            }
            catch
            {
                transaction.Rollback();
                throw;
            }
        }

        public async Task<Dictionary<string, double>> GetAnswerScoresAsync(string formKey, long formDataId)
        {
            using var connection = new MySqlConnection(_connectionString);
            const string sql = @"
                SELECT form_item_id, score 
                FROM td_answer_score 
                WHERE form_key = @FormKey AND form_data_id = @FormDataId";
            
            var scores = await connection.QueryAsync<(string FormItemId, double Score)>(
                sql, new { FormKey = formKey, FormDataId = formDataId });
            return scores.ToDictionary(s => s.FormItemId, s => s.Score);
        }
    }
} 