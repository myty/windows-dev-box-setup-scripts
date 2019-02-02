# Description: Boxstarter Script
# Author: Microsoft
# Common dev settings for desktop app development

# Boxstarter options
$Boxstarter.RebootOk=$false # Allow reboots true or false

# POWERSHELL
Update-ExecutionPolicy Unrestricted

Get-PendingReboot

#---- TEMPORARY ---
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

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Setting up Windows ---
executeScript "SystemConfiguration.ps1";
executeScript "FileExplorerSettings.ps1";
executeScript "RemoveDefaultApps.ps1";
executeScript "CommonDevTools.ps1";
executeScript "Browsers.ps1";
executeScript "OtherDevTools.ps1";

#--- Tools ---
#--- Installing VS and VS Code with Git
# See this for install args: https://chocolatey.org/packages/VisualStudio2017Community
# https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-community
# https://docs.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio#list-of-workload-ids-and-component-ids
# visualstudio2017community
# visualstudio2017professional
# visualstudio2017enterprise

choco install -y visualstudio2017enterprise --package-parameters="'--add Microsoft.VisualStudio.Component.Git'"
Update-SessionEnvironment #refreshing env due to Git install

#--- UWP Workload and installing Windows Template Studio ---
choco install -y visualstudio2017-workload-azure
choco install -y visualstudio2017-workload-universal
choco install -y visualstudio2017-workload-manageddesktop
choco install -y visualstudio2017-workload-nativedesktop

executeScript "WindowsTemplateStudio.ps1";
executeScript "GetUwpSamplesOffGithub.ps1";

executeScript "WSL.ps1";
RefreshEnv
executeScript "HyperV.ps1";
RefreshEnv
executeScript "Docker.ps1";


#--- reenabling critial items ---
Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
