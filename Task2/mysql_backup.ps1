# MySQL Configuration
$MYSQL_USER = "root"
$MYSQL_HOST = "127.0.0.1"
$MYSQL_PORT = "3306"
$DBS_TO_BACKUP = @("classicmodels", "fkdemo", "testdb2")

# Backup Configuration
$BACKUP_DIR = "C:\Users\Administrator\Downloads\Task2\Backups\Daily"
$DATE = Get-Date -Format "yyyy-MM-dd"
$LOG_FILE = "C:\Users\Administrator\Downloads\Task2\Backups\backup.log"

# Create backup directory if not exists
if (!(Test-Path $BACKUP_DIR)) {
    New-Item -ItemType Directory -Path $BACKUP_DIR -Force
}

# Prompt for MySQL password securely
$securePassword = Read-Host "Enter MySQL root password" -AsSecureString
$MYSQL_PASS = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePassword))

# Backup process
foreach ($DB_NAME in $DBS_TO_BACKUP) {
    $BACKUP_FILE = "$BACKUP_DIR\$DB_NAME-$DATE.sql"
    Write-Output "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Memulai backup database $DB_NAME" | Add-Content $LOG_FILE
    
    $env:MYSQL_PWD = $MYSQL_PASS
    & mysqldump --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER $DB_NAME | Out-File -FilePath $BACKUP_FILE
    Remove-Item Env:\MYSQL_PWD
    
    if ($LASTEXITCODE -eq 0) {
        Write-Output "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Backup berhasil: $BACKUP_FILE" | Add-Content $LOG_FILE
    } else {
        Write-Output "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - ERROR: Backup gagal untuk database $DB_NAME" | Add-Content $LOG_FILE
    }
}