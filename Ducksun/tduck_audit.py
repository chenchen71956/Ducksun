import json
import os
import requests
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import time
from smtplib import SMTPException
from email.header import Header
from email.utils import formataddr
import socket

def load_config(config_path):
    os.makedirs(os.path.dirname(config_path), exist_ok=True)

    if not os.path.exists(config_path):
        print(f"警告: {config_path} 不存在，创建模板文件。")
        template_config = {
            "url": "https://example.com/api/data",
            "wechat_webhook_url": "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=YOUR_WEBHOOK_KEY"
        }
        with open(config_path, 'w', encoding='utf-8') as f:
            json.dump(template_config, f, indent=2, ensure_ascii=False)
        print(f"已创建 {config_path} 模板文件，请填写正确的配置信息。")
        return template_config

    with open(config_path, 'r', encoding='utf-8') as f:
        config = json.load(f)
    
    if 'url' not in config or not config['url']:
        print(f"警告: {config_path} 中缺少 'url' 配置或 'url' 为空。")
        config['url'] = "https://example.com/api/data"
        with open(config_path, 'w', encoding='utf-8') as f:
            json.dump(config, f, indent=2, ensure_ascii=False)
        print(f"已在 {config_path} 中添加示例 URL，请更新为正确的 URL。")
    
    return config

def load_audit_fields(audit_fields_path):
    try:
        with open(audit_fields_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        return data
    except FileNotFoundError:
        print(f"错误: 找不到文件 {audit_fields_path}")
        return None
    except json.JSONDecodeError:
        print(f"错误: {audit_fields_path} 不是有效的 JSON 文件")
        return None

def fetch_data(url):
    try:
        response = requests.get(url)
        
        response.raise_for_status()
        
        data = response.json()
        if not isinstance(data, dict):
            print(f"API返回的数据不是字典类型，而是 {type(data)}")
            return None
        
        if 'data' not in data:
            print("API返回的数据中没有 'data' 键")
            return None
        
        if 'records' not in data['data']:
            print("API返回的数据中没有 'data.records' 键")
            return None
        
        if not isinstance(data['data']['records'], list):
            print(f"'data.records' 不是列表类型，而是 {type(data['data']['records'])}")
            return None
        
        return data
    except requests.RequestException as e:
        print(f"获取数据时发生请求错误: {e}")
    except json.JSONDecodeError as e:
        print(f"无法解析API返回的JSON数据: {e}")
    except Exception as e:
        print(f"获取数据时发生未知错误: {e}")
        import traceback
        traceback.print_exc()
    return None

def save_results(results, output_path):
    existing_results = []
    if os.path.exists(output_path):
        try:
            with open(output_path, 'r', encoding='utf-8') as f:
                content = f.read().strip()
                if content:
                    existing_results = json.loads(content)
                else:
                    print(f"警告：{output_path} 文件为空，将创建新的结果列表。")
        except json.JSONDecodeError:
            print(f"警告：{output_path} 文件包含无效的 JSON 数据，将创建新的结果列表。")
    else:
        print(f"警告：{output_path} 文件不存在，将创建新文件。")
    
    existing_results.extend(results)
    
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(existing_results, f, indent=2, ensure_ascii=False)

def load_players(player_path):
    if os.path.exists(player_path):
        with open(player_path, 'r', encoding='utf-8') as f:
            return json.load(f)
    return {"players": []}

def save_players(players, player_path):
    email_list = list(set(player['email'] for player in players['players']))
    with open(player_path, 'w', encoding='utf-8') as f:
        json.dump({"emails": email_list}, f, indent=2, ensure_ascii=False)

def audit_data(data, audit_fields, reviewed_ids, players):
    results = []
    for record in data['data']['records']:
        if record['id'] in reviewed_ids:
            continue
        
        score = 0
        audit_result = {
            'id': record['id'],
            'score': score,
            'reviewed': True,
            'details': {}
        }

        email = record['originalData'].get("input1725899166854", "未找到邮件")
        player_id = record['originalData'].get("input1725903676830", "未找到玩家ID")
        audit_result['email'] = email
        audit_result['player_id'] = player_id
        
        player_info = {
            "email": email,
            "player_id": player_id
        }
        if player_info not in players['players']:
            players['players'].append(player_info)
        
        for field in audit_fields['id']:
            value = record['originalData'].get(field)
            if value:
                audit_result['details'][field] = value
                if field in audit_fields['审核字段']:
                    criteria = audit_fields['审核字段'][field]
                    if value in criteria:
                        score += criteria[value]
        
        audit_result['score'] = score
        results.append(audit_result)
        
        print(f"ID: {audit_result['id']}")
        print(f"玩家ID: {player_id}")
        print(f"玩家邮箱: {email}")
        print(f"分数: {audit_result['score']}")
        print("详细信息:")
        for field, value in audit_result['details'].items():
            print(f"  {field}: {value}")
        print("-" * 50)
    
    return results, players

def load_html_template(template_path):
    try:
        with open(template_path, 'r', encoding='utf-8') as f:
            return f.read()
    except FileNotFoundError:
        print(f"错误: 找不到HTML模板文件 {template_path}")
        return None
    except IOError as e:
        print(f"读取HTML模板文件时出错: {e}")
        return None

def send_wechat_notification(player_id, score, successful):
    config = load_config('config/config.json')
    webhook_url = config.get('wechat_webhook_url')
    
    if not webhook_url:
        print("错误: 未找到企业微信机器人的 webhook URL")
        return
    message = f"玩家 {player_id} 的审核结果：{'通过' if successful else '未通过'}，分数：{score}"
    
    headers = {'Content-Type': 'application/json'}
    payload = {
        "msgtype": "text",
        "text": {
            "content": message
        }
    }
  
    try:
        response = requests.post(webhook_url, json=payload, headers=headers)
        if response.status_code == 200:
            print(f"企业微信通知已发送: {message}")
        else:
            print(f"发送企业微信通知失败: {response.status_code}, {response.text}")
    except Exception as e:
        print(f"发送企业微信通知时出错: {e}")

def send_email(score, email, player_id, successful):
    email_config = load_email_config('config/wmail_config.json')
    if email_config is None:
        print("无法加载邮件配置,邮件发送失败。")
        return

    sender_email = email_config['username']
    receiver_email = email
    password = email_config['password']

    message = MIMEMultipart()
    message["From"] = formataddr(("空城里", sender_email))
    message["To"] = formataddr((player_id, receiver_email))
    message["Subject"] = Header("关于您在【空城里】的审核通知", 'utf-8')

    template_path = 'tduck/HMD.html'
    html_template = load_html_template(template_path)
    if html_template is None:
        print("无法加载HTML模板,邮件发送失败。")
        return

    try:
        html_content = html_template.replace('{name}', str(player_id))
        html_content = html_content.replace('{scr}', str(score))
        html_content = html_content.replace('{state}', "通过" if successful else "未通过")
    except Exception as e:
        print(f"替换HTML模板变量时出错: {e}")
        return

    message.attach(MIMEText(html_content, "html", "utf-8"))

    try:
        with smtplib.SMTP_SSL(email_config['smtp_server'], port=email_config['smtp_port'], timeout=30) as server:
            server.ehlo('localhost')
            server.login(sender_email, password)
            server.send_message(message)
        print(f"审核结果邮件已发送至 {receiver_email}。")


        send_wechat_notification(player_id, score, successful)
    except socket.gaierror as e:
        print(f"DNS解析错误或网络连接问题: {e}")
        print(f"请检查SMTP服务器地址 '{email_config['smtp_server']}' 是否正确")
    except smtplib.SMTPAuthenticationError as e:
        print(f"SMTP身份验证错误: {e}")
        print("请检查用户名和密码是否正确")
    except Exception as e:
        print(f"发送邮件至 {receiver_email} 时出错: {e}")
        print(f"错误类型: {type(e)}")
        import traceback
        traceback.print_exc()

def load_email_config(email_config_path):
    os.makedirs(os.path.dirname(email_config_path), exist_ok=True)

    if not os.path.exists(email_config_path):
        print(f"警告: {email_config_path} 不存在，创建模板文件。")
        template_config = {
            "smtp_server": "smtp.example.com",
            "smtp_port": 587,
            "username": "your_email@example.com",
            "password": "your_email_password"
        }
        with open(email_config_path, 'w', encoding='utf-8') as f:
            json.dump(template_config, f, indent=2, ensure_ascii=False)
        print(f"已创建 {email_config_path} 模板文件，请填写正确的配置信息。")
        return None

    try:
        with open(email_config_path, 'r', encoding='utf-8') as f:
            email_config = json.load(f)
        if 'smtp_server' not in email_config or 'smtp_port' not in email_config or 'username' not in email_config or 'password' not in email_config:
            print(f"错误: {email_config_path} 中缺少必要的配置。")
            return None
        return email_config
    except json.JSONDecodeError:
        print(f"错误: {email_config_path} 不是有效的 JSON 文件。")
        return None
    except IOError as e:
        print(f"读取 {email_config_path} 时出错: {e}")
        return None

def main_loop():
    while True:
        try:
            config = load_config('config/config.json')
            audit_fields = load_audit_fields('tduck/quk.json')
            if audit_fields is None:
                print("无法加载审核字段，跳过本次循环。")
                time.sleep(10)
                continue
            
            players = load_players('player.json')
            
            data = fetch_data(config['url'])
            if data is None:
                print("无法获取数据，跳过本次循环。")
                time.sleep(10)
                continue
            
            reviewed_ids = set()
            reviewed_ids_path = 'tduck/reviewed_ids.json'
            if os.path.exists(reviewed_ids_path):
                try:
                    with open(reviewed_ids_path, 'r', encoding='utf-8') as f:
                        content = f.read().strip()
                        if content:
                            reviewed_ids = set(json.loads(content))
                        else:
                            print("警告：reviewed_ids.json 文件为空，将从头开始审核。")
                except json.JSONDecodeError:
                    print("警告：reviewed_ids.json 文件包含无效的 JSON 数据，将从头开始审核。")
            else:
                print("警告：reviewed_ids.json 文件不存在，将从头开始审核。")
            results, updated_players = audit_data(data, audit_fields, reviewed_ids, players)
            
            if results:
                reviewed_ids.update(result['id'] for result in results)
                with open(reviewed_ids_path, 'w', encoding='utf-8') as f:
                    json.dump(list(reviewed_ids), f)
                
                save_results(results, 'tduck/audit_results.json')
                save_players(updated_players, 'tduck/player.json')

                print(f"总共审核了 {len(results)} 条记录。")

                for result in results:
                    score = result['score']
                    email = result['email']
                    player_id = result.get('player_id', '未知玩家')
                    successful = score >= 45
                    send_email(score, email, player_id, successful)

        except Exception as e:
            print(f"在主循环中发生错误: {e}")
            print("错误详情:")
            import traceback
            traceback.print_exc()
            print("程序将在 10 秒后重试。")
        
        time.sleep(10)

if __name__ == "__main__":
    main_loop()
