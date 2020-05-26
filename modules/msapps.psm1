function New-MakeDirectoryForce([string]$path) {
    # Thanks to raydric, this function should be used instead of `mkdir -force`.
    #
    # While `mkdir -force` works fine when dealing with regular folders, it behaves
    # strange when using it at registry level. If the target registry key is
    # already present, all values within that key are purged.
    if (!(Test-Path $path)) {
        #Write-Host "-- Creating full path to: " $path -ForegroundColor White -BackgroundColor DarkGreen
        New-Item -ItemType Directory -Force -Path $path
    }
}

function Uninstall-StoreApps {
     @(
        # default Windows 10 apps
        "*3DBuilder"
        "*Appconnector"
        "*BingFinance"
        "*BingNews"
        "*BingSports"
        "*BingTranslator"
        "*BingWeather"
        #"*FreshPaint"
        "*Microsoft3DViewer"
        "*MicrosoftOfficeHub"
        "*MicrosoftSolitaireCollection"
        "*MicrosoftPowerBIForWindows"
        "*MinecraftUWP"
        #"*MicrosoftStickyNotes"
        "*NetworkSpeedTest"
        "*Office.OneNote"
        #"*OneConnect"
        "*People"
        "*Print3D"
        "*SkypeApp"
        "*Wallet"
        #"*Windows.Photos"
        #"*WindowsAlarms"
        #"*WindowsCalculator"
        #"*WindowsCamera"
        "*windowscommunicationsapps"
        "*WindowsMaps"
        "*WindowsPhone"
        #"*WindowsSoundRecorder"
        #"*WindowsStore"
        "*XboxApp"
        "*XboxGameOverlay"
        "*XboxGamingOverlay"
        "*XboxSpeechToTextOverlay"
        "*Xbox.TCUI"
        "*ZuneMusic"
        "*ZuneVideo"
        
        # Threshold 2 apps
        "*CommsPhone"
        "*ConnectivityStore"
        "*GetHelp"
        "*Getstarted"
        "*Messaging"
        "*Office.Sway"
        "*OneConnect"
        "*WindowsFeedbackHub"

        # Creators Update apps
        #"*Microsoft3DViewer"
        #"*MSPaint"

        #Redstone apps
        "*BingFoodAndDrink"
        "*BingTravel"
        "*BingHealthAndFitness"
        "*WindowsReadingList"

        # Redstone 5 apps
        "*MixedReality.Portal"
        "*ScreenSketch"
        "*XboxGamingOverlay"
        "*YourPhone"

        # non-Microsoft
		"*3dbuilder*"
		"*alarms*"
		"*appconnector*"
		"*appinstaller*"
		"*communicationsapps*"
		"*camera*"
		"*feedback*"
		"*officehub*"
		"*getstarted*"
		"*skypeapp*"
		"*zunemusic*"
		"*zune*"
		"*maps*"
		"*messaging*"
		"*solitaire*"
		"*wallet*"
		"*connectivitystore*"
		"*bingfinance*"
		"*bing*"
		"*zunevideo*"
		"*bingnews*"
		"*onenote*"
		"*oneconnect*"
		"*mspaint*"
		"*people*"
		"*commsphone*"
		"*windowsphone*"
		"*phone*"
		"*photos*"
		"*bingsports*"
		"*sticky*"
		"*sway*"
		"*3d*"
		"*soundrecorder*"
		"*bingweather*"
		"*holographic*"
		"*xbox*"
		"*king*"
		"*Minecraft*"
		"*MarchofEmpires*"
		"*Sketchbook*"
		"*Twitter*"
		"*Keeper*"

        # apps which other apps depend on
        "*Advertising.Xaml"
    ) | ForEach-Object {
        Get-AppxPackage -Name $_ -AllUsers | Remove-AppxPackage -AllUsers
    
        Get-AppXProvisionedPackage -Online |
            Where-Object DisplayName -EQ $_ |
            Remove-AppxProvisionedPackage -Online
    }

    # Prevents Apps from re-installing
    New-MakeDirectoryForce "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "FeatureManagementEnabled" 0
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "OemPreInstalledAppsEnabled" 0
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "PreInstalledAppsEnabled" 0
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SilentInstalledAppsEnabled" 0
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "ContentDeliveryAllowed" 0
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "PreInstalledAppsEverEnabled" 0
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContentEnabled" 0
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338388Enabled" 0
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338389Enabled" 0
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-314559Enabled" 0
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338387Enabled" 0
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338393Enabled" 0
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SystemPaneSuggestionsEnabled" 0

    # Prevents "Suggested Applications" returning
    New-MakeDirectoryForce "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
    Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" "DisableWindowsConsumerFeatures" 1
}