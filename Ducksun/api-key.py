import requests
import json
import time
import hashlib
import os

def calculate_signature(params, secret):
    params['timestamp'] = str(int(time.time() * 1000))
    params_str = json.dumps(params, separators=(',', ':'), sort_keys=True)
    string_to_sign = secret + params_str
    signature = hashlib.md5(string_to_sign.encode()).hexdigest().lower()  
    return signature

def login(account, password, secret):
    now = int(round(time.time() * 1000))
    base_url = "http://bot.cynasck.asia:8999/login/account"
    
    params = {
        "account": account,
        "password": password,
        "timestamp": now
    }
    
    signature = calculate_signature(params, secret)
    url = f"{base_url}?timestamp={now}&sign={signature}"
    
    headers = {
        'Content-Type': 'application/json'
    }
    
    try:
        response = requests.post(url, json=params, headers=headers)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        print(f"请求错误: {e}")
        return {"code": -1, "message": f"请求错误: {str(e)}"}
    except json.JSONDecodeError:
        print("无法解析JSON响应")
        return {"code": -1, "message": "无法解析服务器响应"}

def get_form_api_key(token, form_key, secret):
    now = int(round(time.time() * 1000))
    base_url = "http://bot.cynasck.asia:8999/sync/apikey"
    
    params = {
        "formKey": form_key,
        "timestamp": now
    }
    
    signature = calculate_signature(params, secret)
    url = f"{base_url}?formKey={form_key}&timestamp={now}&sign={signature}"
    
    headers = {
        'Token': token
    }
    
    try:
        response = requests.get(url, headers=headers)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        print(f"请求错误: {e}")
        return {"code": -1, "message": f"请求错误: {str(e)}"}
    except json.JSONDecodeError:
        print("无法解析JSON响应")
        return {"code": -1, "message": "无法解析服务器响应"}

def construct_form_data_url(api_key):
    return f"http://bot.cynasck.asia:8999/sync/form/data?apiKey={api_key}"

def update_config(new_url):
    script_dir = os.path.dirname(os.path.abspath(__file__))
    config_folder = os.path.join(script_dir, 'config')
    config_file = os.path.join(config_folder, 'config.json')
    
    config_data = {}
    if os.path.exists(config_file):
        with open(config_file, 'r', encoding='utf-8') as f:
            config_data = json.load(f)
    config_data['url'] = new_url
    
    os.makedirs(config_folder, exist_ok=True)
    with open(config_file, 'w', encoding='utf-8') as f:
        json.dump(config_data, f, indent=4)
    print("配置文件已更新")

def check_and_update_url():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    config_folder = os.path.join(script_dir, 'config')
    config_file = os.path.join(config_folder, 'config.json')
    
    if not os.path.exists(config_file):
        print("配置文件不存在，将创建新的配置文件")
        return False

    with open(config_file, 'r', encoding='utf-8') as f:
        config_data = json.load(f)
    
    current_url = config_data.get('url')
    if not current_url:
        print("配置文件中没有URL，需要重新登录")
        return False

    try:
        response = requests.get(current_url, verify=False)
        if response.status_code == 200:
            response_data = response.json()
            if response_data.get('code') != 500:
                print("当前URL有效")
                return True
    except Exception as e:
        print(f"检查URL时发生错误: {e}")

    print("当前URL无效，需要重新登录")
    return False

def check_url_validity(url):
    try:
        response = requests.get(url, verify=False)
        if response.status_code == 200:
            response_data = response.json()
            if response_data.get('code') != 500:
                return True
    except Exception as e:
        print(f"检查URL时发生错误: {e}")
    return False

def main_loop():
    account = "admin@tduckcloud.com"
    password = "123456"
    secret = "f6f31a5f2136758f86b67cde583cb125"
    form_key = "hlYd7ZZQ"

    while True:
        script_dir = os.path.dirname(os.path.abspath(__file__))
        config_folder = os.path.join(script_dir, 'config')
        config_file = os.path.join(config_folder, 'config.json')

        if not os.path.exists(config_file):
            print("配置文件不存在，将创建新的配置文件")
            need_login = True
        else:
            with open(config_file, 'r', encoding='utf-8') as f:
                config_data = json.load(f)
            current_url = config_data.get('url')
            if not current_url or not check_url_validity(current_url):
                print("当前URL无效，需要重新登录")
                need_login = True
            else:
                need_login = False

        if need_login:
            login_response = login(account, password, secret)
            if login_response.get('code') == 200:
                token = login_response['data']['token']
                print("登录成功")
                
                form_api_key_response = get_form_api_key(token, form_key, secret)
                if form_api_key_response.get('code') == 200 and 'data' in form_api_key_response:
                    api_key = form_api_key_response['data']
                    form_data_url = construct_form_data_url(api_key)
                    print(f"构造的表单数据URL: {form_data_url}")
                    update_config(form_data_url)
                else:
                    print(f"获取表单API密钥失败: {form_api_key_response.get('message', '未知错误')}")
            else:
                print(f"登录失败: {login_response.get('message', '未知错误')}")

        time.sleep(10)

if __name__ == "__main__":
    main_loop()