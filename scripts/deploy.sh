#!/bin/bash

# Configuration
REPO_DIR="/home/ubuntu/nodejs-express-mysql"
LOG_FILE="/home/ubuntu/deployment.log"
APP_NAME="bezkoder-app"

echo "------------------------------------------" >> $LOG_FILE
echo "Deployment started at: $(date)" >> $LOG_FILE

cd $REPO_DIR || { echo "Directory not found"; exit 1; }

# Pull latest code
git pull origin master >> $LOG_FILE 2>&1

# Install dependencies
npm install >> $LOG_FILE 2>&1

# Restart service using pm2
pm2 restart $APP_NAME >> $LOG_FILE 2>&1

if [ $? -eq 0 ]; then
    echo "Status: Success" >> $LOG_FILE
else
    echo "Status: Failed" >> $LOG_FILE
fi