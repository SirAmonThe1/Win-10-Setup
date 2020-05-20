#####################
# PREREQUISITES
#####################

# Settings
$repoUri = 'https://github.com/PapaDio/setup.git'
$setupPath = "./Dio-setup"

Push-Location "/"

# Adjust the execution policy for a programming environment
Set-ExecutionPolicy Unrestricted -Scope LocalMachine -Force

# Install chocolately, the minimum requirement
Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Clean if necessary
if (Test-Path -Path $setupPath) {
    Remove-Item $setupPath -Recurse -Force
}

# Install git
& choco install git --confirm --limit-output

# Reset the path environment
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 

# Clone the setup repository
& git clone $repoUri $setupPath

# Enter inside the repository and invoke the real set-up process






Set-ExplorerOptions -showHiddenFilesFoldersDrives -showProtectedOSFiles -showFileExtensions
Set-TaskbarSmall

# Powershell
cinst PowerShell
cinst poshgit

#####################
# SOFTWARE
#####################

# 7Zip
cinst 7zip.install

# Some browsers
cinst GoogleChrome
cinst chromium
cinst brave
cinst firefox
cinst firefox-dev --pre 
cinst Opera
cinst microsoft-edge-insider
cinst microsoft-edge-insider-dev


#Plugins and Runtime
cinst javaruntime

# Geek tools
cinst steam
cinst twitch --ignore-checksums

# Dev Tools
cinst git.install
cinst nvm
cinst cascadiacode
cinst vscode
cinst vscode-insiders
cinst gitkraken
cinst github-desktop
cinst postman
cinst fiddler
cinst microsoft-windows-terminal
cinst teamviewer
cinst azure-cli

# Messaging
cinst discord
cinst slack
cinst whatsapp
cinst telegram
cinst microsoft-teams
cinst skype

# Tools
cinst foxitreader
cinst vlc
cinst ccleaner

# Graphic Tools
cinst paint.net

# Audio Tools
cinst audacity
cinst lightworks
cinst screentogif
cinst spotify --ignore-checksums