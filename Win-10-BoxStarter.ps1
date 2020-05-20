#####################
# PREREQUISITES
#####################

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