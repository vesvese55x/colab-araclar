import os
import time
import re
from IPython.core.display import display, HTML
from IPython.display import clear_output
# Modern yazı stiliyle renkli terminal çıktısı
print("\n\n\033[1;37;48;5;214m========================================================== \033[1;37;48;5;202m   COLAB RDP DWAGENT YÖNTEMİ (BELGESELSEMO.COM.TR)   \033[1;37;48;5;214m ==========================================================\033[0m")
print("\n\033[1;36mGerekli işlemler başladı. Bilgilendirme-yönlendirme açıklamaları birazdan görünecektir. Dikkatlice okuyunuz... Teşekkürler...\033[0m")
print("\n\033[1;36mThe required processes have started. Information and guidance instructions will appear shortly. Please read them carefully... Thank you...\033[0m")
print("\n\033[1;37;48;5;214m========================================================== \033[1;37;48;5;202m   COLAB RDP DWAGENT METHOD (BELGESELSEMO.COM.TR)   \033[1;37;48;5;214m ==========================================================\033[0m")


# ttyd'yi indir ve kur (çıktıları gizle)
os.system("apt update > /dev/null 2>&1")
os.system("apt install -y ttyd > /dev/null 2>&1")

# ttyd'yi 7681 portunda başlat (arka planda, nohup ile arka planda çalıştırarak bağlantı kopsa bile devam et)
os.system("nohup ttyd -p 7681 bash > /dev/null 2>&1 &")
time.sleep(4)

# Cloudflared'i indir ve kur (çıktıları gizle)
os.system("wget -O cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb > /dev/null 2>&1")
os.system("dpkg -i cloudflared.deb > /dev/null 2>&1")

# Cloudflared tünelini başlat
os.system("cloudflared tunnel --url localhost:7681 > cloudflared.log 2>&1 &")
time.sleep(5)

# Cloudflared bağlantısını al
link = None
with open("cloudflared.log", "r") as log_file:
    for line in log_file:
        match = re.search(r"https://[a-zA-Z0-9.-]+\.trycloudflare\.com", line)
        if match:
            link = match.group(0)
            break

clear_output(wait=True)

# Terminalde bağlantıyı göster
if link:

    # Kopyalanacak komutlar
    command1 = "wget https://www.dwservice.net/download/dwagent.sh -q -O dwagent.sh && chmod +x dwagent.sh && echo '2' | ./dwagent.sh"
    command2 = "wget -q -O colab-dwagent-belgeselsemo.sh https://raw.githubusercontent.com/vesvese55x/colab-araclar/refs/heads/main/colab-rdp-belgeselsemo/colab-dwagent.sh && bash colab-dwagent-belgeselsemo.sh"

    # HTML + JavaScript ile Butonlar Oluştur
    html_code = f"""
    <html>
    <head>
        <style>
            body {{ font-family: Arial, sans-serif; text-align: left; margin: 20px; }}
            button {{ padding: 10px 20px; font-size: 16px; color: white; border: none; cursor: pointer; border-radius: 5px; margin-right: 10px; }}
            .red-button {{ background-color: #D32F2F; }}
            .red-button:hover {{ background-color: #B71C1C; }}
            .green-button {{ background-color: #4CAF50; }}
            .green-button:hover {{ background-color: #45a049; }}
            .blue-button {{ background-color: #008CBA; }}
            .blue-button:hover {{ background-color: #007BB5; }}
            .spacer {{ margin-top: 20px; }}
            .info-box {{
                border: 2px solid #000;
                padding: 15px;
                background-color: #f9f9f9;
                margin-bottom: 20px;
                display: flex;
            }}
            .info-box .left {{
                width: 50%;
                padding-right: 10px;
                font-weight: bold;
            }}
            .info-box .right {{
                width: 50%;
                padding-left: 10px;
                font-weight: bold;
            }}
        </style>
        <script>
            function copyCommand(command) {{
                var textarea = document.createElement("textarea");
                textarea.value = command;
                document.body.appendChild(textarea);
                textarea.select();
                document.execCommand("copy");
                document.body.removeChild(textarea);
            }}
        </script>
    </head>
    <body>
        <div class="info-box">
            <div class="left">
                <p><font color="#D32F2F">(1) </font>Yeşil butona tıkla, sonra Kırmızı butona tıklayarak Terminal'e git.</p>
                <p><font color="#D32F2F">(2) </font>Ctrl+V tuşlarıyla terminale kodunu yapıştır. (5-7 sn içinde DWagent giriş bilgilerini verecek)</p>
                <p><font color="#D32F2F">(3) </font>Terminal'den aldığımız giriş bilgileriyle <a href="https://access.dwservice.net/login.dw">https://access.dwservice.net/login.dw</a> sitesine gir. Kabuk'a yani ❯_ simgeye tıkla.</p>
                <p><font color="#D32F2F">(4) </font>Mavi butona tıkla, Ctrl+V tuşlarıyla DWagent Kabuk Terminal'ine kodunu yapıştır.</p>
                <p><font color="#D32F2F">(5) </font>Tüm işlemlerin bitmesi için 7-8 dk bekle... İşlem Tamam.</p>
            </div>
            <div class="right">
                <p><font color="#D32F2F">(1) </font>Click the green button, then click the red button to go to the terminal.</p>
                <p><font color="#D32F2F">(2) </font>Paste the code into the terminal using Ctrl+V (DWagent login info will be provided in 5-7 seconds)</p>
                <p><font color="#D32F2F">(3) </font>Log in with the credentials obtained from the terminal at <a href="https://access.dwservice.net/login.dw">https://access.dwservice.net/login.dw</a> and click the ❯_ shell icon.</p>
                <p><font color="#D32F2F">(4) </font>Click the blue button, paste the code into DWagent Shell Terminal using Ctrl+V.</p>
                <p><font color="#D32F2F">(5) </font>Wait for 7-8 minutes for all processes to finish... Process Completed.</p>
            </div>
        </div>
        
        <p></p>
        <center>
        <button class="red-button" onclick="window.open('{link}', '_blank')">TTYD Terminal'e Git<br>(Go to TTYD Terminal)</button>
        <button class="green-button" onclick="copyCommand(`{command1}`)">TTYD Terminal'e kodu kopyalamak için tıklayınız...<br>(Click to copy the code to TTYD Terminal)</button>
        <button class="blue-button" onclick="copyCommand(`{command2}`)">DWAGENT KODU<br>(DWAGENT CODE)</button>
        </center>
        <div class="spacer"></div> 
    </body>
    </html>
    """

    # HTML'yi görüntüle
    display(HTML(html_code))

else:
    print("\033[1;31m❌ URL alınamadı. Cloudflared loglarını kontrol edin.\033[0m")
