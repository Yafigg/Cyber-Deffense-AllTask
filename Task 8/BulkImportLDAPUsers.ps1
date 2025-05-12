# Impor modul yang diperlukan
Import-Module ActiveDirectory

# Parameter konfigurasi
$numUsers = 100
$baseOU = "OU=Test Crew,DC=DIAAS,DC=in"  # Sesuai dengan domain DIAAS.in
$initialPassword = ConvertTo-SecureString "T3st$Cr3w#2024" -AsPlainText -Force # Kata sandi kuat
$departments = @("Engineering", "Marketing", "Finance", "HR", "Operations", "IT", "Customer Support")

# Buat OU Test Crew jika belum ada
try {
    Get-ADOrganizationalUnit -Identity $baseOU
    Write-Host "OU Test Crew sudah ada."
} catch {
    Write-Host "Membuat OU Test Crew..."
    $domainDN = "DC=DIAAS,DC=in"
    New-ADOrganizationalUnit -Name "Test Crew" -Path $domainDN
}

# Hasilkan data pengguna acak dan buat akun AD
Write-Host "Menghasilkan $numUsers pengguna uji..."

for ($i = 1; $i -le $numUsers; $i++) {
    # Hasilkan data pengguna acak
    $firstName = "TestUser$i"
    $lastName = "Last$i"
    $username = "testuser$i"
    $displayName = "$firstName $lastName"
    $department = $departments[(Get-Random -Maximum $departments.Length)]
    $email = "$username@DIAAS.in"
    
    # Buat pengguna
    try {
        New-ADUser -Name $displayName `
                  -GivenName $firstName `
                  -Surname $lastName `
                  -SamAccountName $username `
                  -UserPrincipalName "$username@DIAAS.in" `
                  -DisplayName $displayName `
                  -EmailAddress $email `
                  -Description "Pengguna uji $i" `
                  -Department $department `
                  -Path $baseOU `
                  -AccountPassword $initialPassword `
                  -Enabled $true `
                  -PasswordNeverExpires $true `
                  -ChangePasswordAtLogon $false
        
        Write-Host "Pengguna berhasil dibuat: $username ($displayName)"
    } catch {
        Write-Host "Gagal membuat pengguna $username. Error: $_" -ForegroundColor Red
    }
}

Write-Host "Selesai membuat $numUsers pengguna uji dalam OU Test Crew."