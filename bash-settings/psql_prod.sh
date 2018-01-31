#!/bin/bash
echo "Pass: Jof49xS2"
psql --set=sslmode=require -h fh-prod.enrique-3e65.aivencloud.com -p 12230 -d "dbname=defaultdb sslmode=require" -U avnadmin 
