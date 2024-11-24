namespace DuckSun.Models
{
    public class DatabaseConfig
    {
        public string Server { get; set; }
        public string Database { get; set; }
        public string UserId { get; set; }
        public string Password { get; set; }
        public int Port { get; set; } = 3306;
        
        public string GetConnectionString()
        {
            return $"Server={Server};Port={Port};Database={Database};User={UserId};Password={Password};Allow User Variables=True;Convert Zero Datetime=True;ConnectionTimeout=30;CharSet=utf8mb4;AllowPublicKeyRetrieval=True;SslMode=None;";
        }
    }
} 