import subprocess
import urllib.request
import urllib.parse
import json
import os

p = subprocess.Popen(['git', 'credential', 'fill'], stdin=subprocess.PIPE, stdout=subprocess.PIPE, text=True)
out, _ = p.communicate('protocol=https\nhost=github.com\n\n')
token = [l[9:] for l in out.splitlines() if l.startswith('password=')][0]

release_data = json.dumps({
    'tag_name': 'v1.0.0',
    'name': '🎭 凉笙歌剧院 (Liangsheng Opera House) v1.0.0 官方正式开源发布版',
    'body': """## 🎭 凉笙歌剧院 (Liangsheng Opera House) v1.0.0 盛大启幕！

> **“台上皆为古今哲匠，案头尽是万卷经纶；幕起之时解构盲区，曲终之刻定策乾坤。”**

### 📦 核心特性
- **双模唤醒**：支持自然语言口令（`有请凉笙歌剧院` / `歌剧院开戏`）与快捷暗号（`/curtain-up` / `/opera`）；
- **三大官方黄金智囊库**（即开即用）：
  1. 查理·芒格 +《穷查理宝典》（认知对抗派）
  2. 安迪·格鲁夫 +《只有偏执狂才能生存》（激进破局派）
  3. 稻盛和夫 +《活法》与阿米巴经营哲学（系统治理派）
- **工业级全流程闭环**：结合女娲（Nuwa）6D 心智蒸馏与仓颉（Cangjie）RIA-TV++ 法典工具箱；
- **双轨自适应登台协议**：独立舞台与主窗口原地聚焦开演无缝融合，彻底告别会话卡死；
- **全平台一键安装**：支持 Windows（双击 `install.bat`）、macOS/Linux（`install.sh`）。

### 📄 资源下载
- 本 Release 包含便携一键安装包 `liangsheng-theater-v1.0-release.zip` 与 4 页精编矢量指南 `凉笙歌剧院_全盘解析与极速使用指南.pdf`。""",
    'draft': False,
    'prerelease': False
}).encode('utf-8')

req = urllib.request.Request(
    'https://api.github.com/repos/liangshengsheng12333/liangsheng-theater/releases',
    data=release_data,
    headers={'Authorization': f'token {token}', 'Content-Type': 'application/json', 'User-Agent': 'python'}
)

try:
    with urllib.request.urlopen(req) as resp:
        rel = json.loads(resp.read().decode())
        upload_url_base = rel['upload_url'].split('{')[0]
        print('Release URL:', rel.get('html_url'))
        
        # Upload zip asset
        zip_path = 'liangsheng-theater-v1.0-release.zip'
        if os.path.exists(zip_path):
            with open(zip_path, 'rb') as f:
                zip_bytes = f.read()
            upload_req = urllib.request.Request(
                f"{upload_url_base}?name={urllib.parse.quote(zip_path)}",
                data=zip_bytes,
                headers={'Authorization': f'token {token}', 'Content-Type': 'application/zip', 'User-Agent': 'python'}
            )
            with urllib.request.urlopen(upload_req) as u_resp:
                print('Uploaded asset:', zip_path)

        # Upload pdf asset
        pdf_path = '凉笙歌剧院_全盘解析与极速使用指南.pdf'
        if os.path.exists(pdf_path):
            with open(pdf_path, 'rb') as f:
                pdf_bytes = f.read()
            upload_req = urllib.request.Request(
                f"{upload_url_base}?name={urllib.parse.quote(pdf_path)}",
                data=pdf_bytes,
                headers={'Authorization': f'token {token}', 'Content-Type': 'application/pdf', 'User-Agent': 'python'}
            )
            with urllib.request.urlopen(upload_req) as u_resp:
                print('Uploaded asset:', pdf_path)
except Exception as e:
    print('Error creating release:', e)
