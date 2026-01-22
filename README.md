# 🔐 SSL Certificate Checker

Never let a domain expire again! This lightweight tool calculates exactly how many days are left on an SSL certificate and alerts you in **RED** if it's critical (< 30 days). 🚀

## 🐳 Quick Start
No dependencies needed—just Docker!

```bash
docker build -t ssl-check .
docker run --rm ssl-check google.com
