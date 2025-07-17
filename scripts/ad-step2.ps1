# Installation du role DHCP
Write-Host "Installation du role DHCP..."
Install-WindowsFeature -Name DHCP -IncludeManagementTools

# Vérification de l'installation du role DHCP
if ((Get-WindowsFeature -Name DHCP).Installed) {
    Write-Host "Le rôle DHCP a été installé avec succès." -ForegroundColor Green
} else {
    Write-Host "L'installation du rôle DHCP a échoué." -ForegroundColor Red
    Exit
}

# Configuration de DHCP 
Write-Host "Configuration du serveur DHCP..."

# Autorisation du serveur DHCP 
Add-DhcpServerInDc -DnsName "srv-ad.entrepriseY.local" -IpAddress 192.168.1.2

# Démarrage du service DHCP
Start-Service -Name DHCPServer

# Création d'une plage d'adresses (de 192.168.1.100 à  192.168.1.200)
Add-DhcpServerV4Scope -Name "ScopeEntrepriseY" -StartRange 192.168.1.100 -EndRange 192.168.1.200 -SubnetMask 255.255.255.0 -State Active

# Configuration d'une durée du bail
Set-DhcpServerv4Scope -ScopeId 192.168.1.0 -LeaseDuration 8.00:00:00

Restart-Service dhcpserver

# Vérification du service DHCP
Write-Host "Vérification de l'état du service DHCP..."
Get-Service -Name dhcp

Write-Host "Installation et configuration du role DHCP terminé avec succès." -ForegroundColor Green
