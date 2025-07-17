# Telechargement de NSClient++
Write-Host "Telechargement de NSClient++..."
Invoke-WebRequest -Uri https://github.com/mickem/nscp/releases/download/0.5.2.39/NSCP-0.5.2.39-x64.msi -OutFile C:\nsclient.msi


# Installation silencieuse
Write-Host "Installation de NSClient++..."
Start-Process msiexec.exe -ArgumentList '/i', 'C:\nsclient.msi', '/qn', '/norestart' , 'ADDLOCAL=ALL', 'ALLOW_ARGUMENTS=1', 'ENABLE_NSCLIENT=1', 'ENABLE_NRPE=1' -Wait


# Attente que les fichiers soient bien crees
Start-Sleep -Seconds 10

# Chemin du fichier de configuration
$configPath = "C:\Program Files\NSClient++\nsclient.ini"

# Verification et modification de la config
if (Test-Path $configPath) {
    Write-Host "Configuration de NSClient++..."

    # Active les modules necessaires
    Add-Content $configPath "`n[/modules]"
    Add-Content $configPath "NRPEServer = enabled"
    Add-Content $configPath "CheckExternalScripts = enabled"

    # Configuration NRPEServer
    Add-Content $configPath "`n[/settings/NRPE/server]"
    Add-Content $configPath "allow arguments = true"
    Add-Content $configPath "allow nasty characters = true"
    Add-Content $configPath "verify mode = none"
    Add-Content $configPath "insecure = true"
    Add-Content $configPath "allowed hosts = 192.168.1.4"

    # Configuration de base pour CheckExternalScripts
    Add-Content $configPath "`n[/settings/external scripts]"
    Add-Content $configPath "allow arguments = true"
}


# Redemarrage du service
Write-Host "Demarrage du service NSClient++..."
Restart-Service -Name nscp

Write-Host "Installation et configuration de NSClient++ terminee avec succes."
