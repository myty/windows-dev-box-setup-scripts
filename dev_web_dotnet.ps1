# Description: Boxstarter Script  
# Author: Microsoft
# Common dev settings for web dev

Disable-UAC

#---- POWERSHELL GALLERY ---
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
$Modules = @(
    # "PSReadline"
    "oh-my-posh"
    "Pscx"
    "TabExpansionPlusPlus"
    "posh-git"
)

ForEach ($Module in $Modules) {
    if (Get-Module -ListAvailable -Name $Module) {
        Update-Module -Name $Module
    }
    else {
        Install-Module -Name $Module -AllowClobber
    }
}

#--- Windows Features ---
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions

#--- File Explorer Settings ---
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

#--- Tools ---
choco install -y git-credential-manager-for-windows
choco install -y git -params '"/GitAndUnixToolsOnPath /WindowsTerminal"'
choco install -y 7zip.install
choco install -y sysinternals
choco install -y nodejs
choco install -y yarn
choco install -y filezilla.commandline
choco install -y ngrok.portable
choco install -y scriptcs
choco install -y sudo
choco install -y microsoft-build-tools 

#--- Apps ---
choco install -y fiddler4
choco install -y hyper
choco install -y firefox
choco install -y googlechrome
choco install -y docker-for-windows
choco install -y cmder
choco install -y terminals
choco install -y sqlnotebook
choco install -y windirstat
choco install -y sql-server-management-studio
choco install -y vscode
choco install -y insomnia-rest-api-client

#--- Visual Studio ---
choco install -y visualstudio2017enterprise
choco install -y visualstudio2017-workload-netweb --package-parameters "--productId Microsoft.VisualStudio.Product.Enterprise --channelId VisualStudio.15.Release --includeOptional"

#--- Windows Subsystems/Features ---
choco install -y Microsoft-Hyper-V-All -source windowsFeatures
choco install -y Microsoft-Windows-Subsystem-Linux -source windowsfeatures
choco install -y IIS-WebServerRole -source windowsFeatures
choco install -y OpenSSH.Client -source windowsFeatures

#--- Fonts ---
choco install -y inconsolata
choco install -y ubuntu.font

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
