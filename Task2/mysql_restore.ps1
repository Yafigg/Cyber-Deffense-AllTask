# MySQL Configuration
$MYSQL_USER = "root"
$MYSQL_HOST = "127.0.0.1"
$MYSQL_PORT = "3306"
$LOG_FILE = "C:\Users\Administrator\Downloads\Task2\Restore\Logs\restore.log"

# Check parameters
if ($args.Count -eq 0) {
    Write-Host "Usage: .\mysql_restore.ps1 <backup_file_path>"
    exit 1
}

$BACKUP_FILE = $args[0]

# Extract database name from backup file name
$DB_NAME = ([System.IO.Path]::GetFileNameWithoutExtension($BACKUP_FILE)).Split('-')[0]

# Prompt for MySQL password securely
$securePassword = Read-Host "Enter MySQL root password" -AsSecureString
$MYSQL_PASS = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePassword))

# Restore process
Write-Output "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Starting restore for database $DB_NAME from $BACKUP_FILE" | Add-Content $LOG_FILE

$env:MYSQL_PWD = $MYSQL_PASS

# Create database if not exists
& mysql --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --execute="CREATE DATABASE IF NOT EXISTS $DB_NAME;"

# Restore the backup
Get-Content $BACKUP_FILE | & mysql --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER $DB_NAME

Remove-Item Env:\MYSQL_PWD

if ($LASTEXITCODE -eq 0) {
    Write-Output "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Restore successful to database: $DB_NAME" | Add-Content $LOG_FILE
} else {
    Write-Output "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - ERROR: Restore failed for database: $DB_NAME" | Add-Content $LOG_FILE
}