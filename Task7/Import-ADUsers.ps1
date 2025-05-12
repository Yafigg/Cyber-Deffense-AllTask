# Import Modul Active Directory
Import-Module ActiveDirectory

# Tentukan lokasi file log
$logFile = "C:\Logs\ADUserImport_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

# Buat direktori log jika belum ada
$logDir = Split-Path $logFile
if (!(Test-Path $logDir)) {
    New-Item -Path $logDir -ItemType Directory | Out-Null
}

# Fungsi untuk menulis ke file log
function Write-Log {
    param (
        [string]$Message,
        [string]$Level = "INFO"
    )
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "[$timestamp] [$Level] $Message"
    
    Add-Content -Path $logFile -Value $logEntry
    Write-Host $logEntry
}

# Coba impor file CSV
try {
    Write-Log "Memulai proses impor pengguna AD"
    $users = Import-Csv -Path ".\Import-ADUsers.csv"
    Write-Log "Berhasil mengimpor CSV dengan $($users.Count) data pengguna"
}
catch {
    Write-Log "Gagal mengimpor file CSV: $_" "ERROR"
    exit
}

# Set opsi password default
# Dapatkan OU yang benar dari domain Anda
$domainInfo = Get-ADDomain
$defaultOU = "CN=Users,$($domainInfo.DistinguishedName)"  # Struktur default untuk user container
Write-Log "Menggunakan OU: $defaultOU" "INFO"

# Proses setiap pengguna dalam CSV
foreach ($user in $users) {
    try {
        # Cek apakah field yang diperlukan ada
        if (-not ($user.FirstName -and $user.LastName -and $user.Username)) {
            Write-Log "Melewati pengguna dengan data tidak lengkap: $($user.FirstName) $($user.LastName)" "WARNING"
            continue
        }
        
        # Cek apakah pengguna sudah ada
        if (Get-ADUser -Filter "SamAccountName -eq '$($user.Username)'" -ErrorAction SilentlyContinue) {
            Write-Log "Pengguna $($user.Username) sudah ada di AD, dilewati" "WARNING"
            continue
        }
        
        # Siapkan parameter pengguna
        $userParams = @{
            SamAccountName = $user.Username
            UserPrincipalName = "$($user.Username)@$($domainInfo.DNSRoot)"
            Name = "$($user.FirstName) $($user.LastName)"
            GivenName = $user.FirstName
            Surname = $user.LastName
            EmailAddress = $user.Email
            Department = $user.Department
            Title = $user.JobTitle
            Enabled = $true
            DisplayName = "$($user.FirstName) $($user.LastName)"
            Path = $defaultOU
            AccountPassword = (ConvertTo-SecureString $user.Password -AsPlainText -Force)
        }
        
        # Buat pengguna
        New-ADUser @userParams
        
        # Set opsi password tambahan setelah pengguna dibuat
        Set-ADUser -Identity $user.Username -PasswordNeverExpires $true -CannotChangePassword $false
        
        Write-Log "Berhasil membuat pengguna: $($user.Username) ($($user.FirstName) $($user.LastName))"
    }
    catch {
        Write-Log "Error membuat pengguna $($user.Username): $_" "ERROR"
    }
}

Write-Log "Proses impor pengguna AD selesai"