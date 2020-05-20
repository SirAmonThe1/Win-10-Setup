# Settings
$repoUri = 'https://github.com/SirAmonThe1/Win-10-Setup.git'
$setupPath = "./Dio-setup"

Push-Location "/"

# Adjust the execution policy for a programming environment

	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "#####################"
	Write-Output "# ----- Adjust the execution policy for a programming environment"
	Write-Output "#####################"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"

Set-ExecutionPolicy Unrestricted -Scope LocalMachine -Force

# Install chocolately, the minimum requirement

	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "#####################"
	Write-Output "# ----- Install chocolately, the minimum requirement"
	Write-Output "#####################"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"

Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Clean if necessary
if (Test-Path -Path $setupPath) {
    Remove-Item $setupPath -Recurse -Force
}

# Install git

	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "#####################"
	Write-Output "# ----- Install git"
	Write-Output "#####################"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"

& choco install git --confirm --limit-output

# Reset the path environment
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 

# Clone the setup repository
& git clone $repoUri $setupPath

# Enter inside the repository and invoke the real set-up process
Push-Location $setupPath
Import-Module '.\setup.psm1' -Force

Get-ChildItem .\modules\*.psm1 | Import-Module -Force

if ($debug -ne $true) {
    
	#####################
	# Vorbereitung
	#####################
	
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "# ----- Beginning the Set-Up"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	

    $global:setupPath = (Get-Location).Path

    # Make sure that Git Bash does use colors on Windows
    [System.Environment]::SetEnvironmentVariable("FORCE_COLOR", "true", "Machine")
	

	
	#####################
	# Windows-Einstellungen
	#####################
	
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "#####################"
	Write-Output "# ----- Windows-Einstellungen"
	Write-Output "#####################"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	
    Write-Output "## Install-UserProfile"
	Install-UserProfile
	Write-Output "## Install-StartLayout ./configs/start-layout.xml"
    Install-StartLayout "./configs/start-layout.xml"
	Write-Output "## Install-WindowsDeveloperMode"
    Install-WindowsDeveloperMode
    Write-Output "## Set-HidePeopleOnTaskbar $true"
    Set-HidePeopleOnTaskbar $true
    Write-Output "## Set-ShowPeopleOnTaskbar $false"
    Set-ShowPeopleOnTaskbar $false
    Write-Output "## Set-SmallButtonsOnTaskbar $true"
    Set-SmallButtonsOnTaskbar $true
    Write-Output "## Set-MultiMonitorTaskbarMode "2""
    Set-MultiMonitorTaskbarMode "2"
    Write-Output "## Set-DisableWindowsDefender $true"
    Set-DisableWindowsDefender $true
    Write-Output "## Set-DarkTheme $true"
    Set-DarkTheme $true
    Write-Output "## Set-DisableLockScreen $true"
    Set-DisableLockScreen $true
    Write-Output "## Set-DisableAeroShake $true"
    Set-DisableAeroShake $true
    Write-Output "## Set-EnableLongPathsForWin32 $true"
    Set-EnableLongPathsForWin32 $true
    Write-Output "## Set-OtherWindowsStuff"
    Set-OtherWindowsStuff
    Write-Output "## Remove-3dObjectsFolder"
    Remove-3dObjectsFolder
    Write-Output "## Disable-AdministratorSecurityPrompt"
    Disable-AdministratorSecurityPrompt
    Write-Output "## Disable-UselessServices"
    Disable-UselessServices
    Write-Output "## Disable-EasyAccessKeyboard"
    Disable-EasyAccessKeyboard
    Write-Output "## Set-FolderViewOptions"
    Set-FolderViewOptions
    Write-Output "## Disable-AeroShaking"
    Disable-AeroShaking
    Write-Output "## Uninstall-StoreApps"
    Uninstall-StoreApps
	Write-Output "## Deactivate XPS and FAX-Services"
    @(
        "Printing-XPSServices-Features"
        "Printing-XPSServices-Features"
        "FaxServicesClientPackage"
    ) | ForEach-Object { Disable-WindowsOptionalFeature -FeatureName $_ -Online -NoRestart }

    @(
        "Containers-DisposableClientVM" # Windows Sandbox
    ) | ForEach-Object { Enable-WindowsOptionalFeature -FeatureName $_ -Online -NoRestart }
	
	
	
	
	
#####################
# SOFTWARE
#####################

	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "#####################"
	Write-Output "# ----- SOFTWARE"
	Write-Output "#####################"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	Write-Output "****"
	
	# Installationen mit Checksum-Fehler
	cinst teamviewer --ignore-checksums
	
	

    $chocopkgs = Get-ChocoPackages "./configs/chocopkg.txt"
    Install-ChocoPackages $chocopkgs 1
	
	$confirmation = Read-Host "Extra-Software"
	if ($confirmation -eq 'y') {
    Install-ChocoPackages $chocopkgs 2
	cinst googlechrome --ignore-checksums
	}
	
	$confirmation = Read-Host "Spiele-Software"
	if ($confirmation -eq 'y') {
    Install-ChocoPackages $chocopkgs 3
	cinst twitch --ignore-checksums
	}
	
	$confirmation = Read-Host "Development-Software"
	if ($confirmation -eq 'y') {
    Install-ChocoPackages $chocopkgs 4
	}


    Remove-TempDirectory

    # Clean
    Pop-Location
    Pop-Location
}

