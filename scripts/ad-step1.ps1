$DomainName = "entrepriseY.local"
$SafeModePassword = ConvertTo-SecureString "P@ssw0rd123" -AsPlainText -Force

Install-WindowsFeature -Name AD-Domain-Services, DNS, DHCP -IncludeManagementTools

Install-ADDSForest `
    -DomainName $DomainName `
    -SafeModeAdministratorPassword $SafeModePassword `
    -DomainNetbiosName "ENTREPRISEY" `
    -Force `
    -InstallDns:$true
