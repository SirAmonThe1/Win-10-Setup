# Settings
$repoUri = 'https://github.com/SirAmonThe1/Win-10-Setup.git'
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
Push-Location $setupPath
Import-Module '.\setup.psm1' -Force

Get-ChildItem .\modules\*.psm1 | Import-Module -Force

if ($debug -ne $true) {
    
	#####################
	# PREREQUISITES
	#####################
	
	Write-Output "Beginning the set-up"

    $global:setupPath = (Get-Location).Path

    # Make sure that Git Bash does use colors on Windows
    [System.Environment]::SetEnvironmentVariable("FORCE_COLOR", "true", "Machine")
	
	
	
	
	#####################
	# Windows-Einstellungen
	#####################
	
    Write-Output "Install-UserProfile"
	Install-UserProfile
    Install-StartLayout "./configs/start-layout.xml"
    Install-WindowsDeveloperMode
    Set-HidePeopleOnTaskbar $true
    Set-ShowPeopleOnTaskbar $false
    Set-SmallButtonsOnTaskbar $true
    Set-MultiMonitorTaskbarMode "2"
    Set-DisableWindowsDefender $true
    Set-DarkTheme $true
    Set-DisableLockScreen $true
    Set-DisableAeroShake $true
    Set-EnableLongPathsForWin32 $true
    Set-OtherWindowsStuff
    Remove-3dObjectsFolder
    Disable-AdministratorSecurityPrompt
    Disable-UselessServices
    Disable-EasyAccessKeyboard
    Set-FolderViewOptions
    Disable-AeroShaking
    Uninstall-StoreApps

    @(
        "Printing-XPSServices-Features"
        "Printing-XPSServices-Features"
        "FaxServicesClientPackage"
    ) | ForEach-Object { Disable-WindowsOptionalFeature -FeatureName $_ -Online -NoRestart }

    @(
        "TelnetClient"
        "HypervisorPlatform"
        "NetFx3"
        "Microsoft-Hyper-V-All"
        "Containers-DisposableClientVM" # Windows Sandbox
    ) | ForEach-Object { Enable-WindowsOptionalFeature -FeatureName $_ -Online -NoRestart }

    $chocopkgs = Get-ChocoPackages "./configs/chocopkg.txt"
    Install-ChocoPackages $chocopkgs 1
    Install-ChocoPackages $chocopkgs 2
    Install-ChocoPackages $chocopkgs 3


    Get-ChildItem .\modules\common.psm1 | Import-Module -Force
    Get-ChildItem .\modules\*.psm1 | Import-Module -Force
    $global:setupPath = (Get-Location).Path

    Invoke-TemporaryGitDownload "debloat" "https://github.com/W4RH4WK/Debloat-Windows-10" {
        & "./scripts/block-telemetry.ps1"
    }


    # Install Dracula theme for all terminals
    Invoke-TemporaryZipDownload "colortool" "https://github.com/microsoft/terminal/releases/download/1904.29002/ColorTool.zip" {
        $termColorsPath = Join-Path $global:setupPath "configs/Dracula-ColorTool.itermcolors"
        (& ./colortool "-d" "-b" "-x" $termColorsPath)
        
        Set-PSReadlineOption -Color @{
            "Command" = [ConsoleColor]::Green
            "Parameter" = [ConsoleColor]::Gray
            "Operator" = [ConsoleColor]::Magenta
            "Variable" = [ConsoleColor]::White
            "String" = [ConsoleColor]::Yellow
            "Number" = [ConsoleColor]::Blue
            "Type" = [ConsoleColor]::Cyan
            "Comment" = [ConsoleColor]::DarkCyan
        }
    }

    Remove-TempDirectory

    # Clean
    Pop-Location
    Pop-Location
}

