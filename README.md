# 🔐 SSL Certificate Checker with Email Alerts

Never let a domain expire again! This lightweight Bash script monitors your SSL certificate expiration date. It provides colored terminal output for manual checks and sends **automatic email notifications** when the certificate is close to expiration.

## 🚀 Features

* **Real-time Checks:** Fetches the SSL certificate directly from the server.
* **Color Coded:** Visual feedback in the terminal (Green = Valid, Yellow = Warning, Red = Critical/Expired).
* **Email Notifications:** Sends an email alert if the certificate expires in less than `X` days (default: 7).
* **Lightweight:** Uses standard tools (`openssl`) and a simple SMTP client (`msmtp`).

---

## 🛠️ Prerequisites

The script runs natively on Linux (Ubuntu/Debian) and requires `openssl` and `msmtp` (for sending emails).

### 1. Install Dependencies
```bash
sudo apt update
sudo apt install openssl msmtp msmtp-mta ca-certificates
2. Configure SMTP (Gmail Example)
Create the configuration file in your home directory:

Bash
nano ~/.msmtprc
Paste the following configuration (replace with your details):

Plaintext
defaults
auth           on
tls            on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
logfile        ~/.msmtp.log

account        gmail
host           smtp.gmail.com
port           587
from           your_email@gmail.com
user           your_email@gmail.com
password       YOUR_GOOGLE_APP_PASSWORD

account default : gmail
Note: For Gmail, you must use an App Password (generated in Google Account -> Security), not your regular login password.

Secure the file (Critical step):

Bash
chmod 600 ~/.msmtprc
⚙️ Configuration
Open check_ssl.sh and set your preferences at the top of the file:

Bash
ADMIN_EMAIL="your_email@company.com" # Who receives the alerts
ALERT_DAYS=7                         # Days before expiry to send an alert
📖 Usage
Manual Run
You can run the script manually to check the status in your terminal:

Bash
./check_ssl.sh yourdomain.com
Output:

Plaintext
Checking SSL certificate for domain: yourdomain.com...
===============================
Expiry Date : May 25 12:00:00 2026 GMT
Status      : VALID (97 days remaining)
===============================
Automatic Monitoring (Cron Job)
To check daily (e.g., at 09:00 AM) and receive emails only when necessary, add it to your crontab.

Open crontab:

Bash
crontab -e
Add the following line:

Code snippet
0 9 * * * /path/to/your/check_ssl.sh yourdomain.com > /dev/null 2>&1
🐳 Legacy Docker Usage (Optional)
If you prefer the old Docker method (without email alerts):

Bash
docker build -t ssl-check .
docker run --rm ssl-check google.com
