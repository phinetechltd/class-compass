@echo off
cd /d "C:\xampp\apache\bin"
httpd.exe -f "C:\Users\ondie\Downloads\Mighty School Pro v1.6\cleaned\dev-server\httpd-classcompass.conf" -D FOREGROUND
