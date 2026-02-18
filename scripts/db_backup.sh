#!/bin/bash

# Configuration
DB_NAME="testdb"
DB_USER="root"
DB_PASS="your_password"
S3_BUCKET="s3://your-unique-backup-bucket-name"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_PATH="/home/ubuntu/backups/db_backup_$TIMESTAMP.sql"

# Create backup directory if not exists
mkdir -p /home/ubuntu/backups

# Take MySQL backup
mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_PATH

# Upload to S3
aws s3 cp $BACKUP_PATH $S3_BUCKET/

# Optional: Remove local file after upload to save space
if [ $? -eq 0 ]; then
    rm $BACKUP_PATH
    echo "Backup $TIMESTAMP uploaded successfully."
fi