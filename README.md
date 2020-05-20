# Set-up from a fresh install, with just one line of code

## About

This is a public repository of a script to set-up, from a fresh Windows 10 installation, a development or multimedia production environment with just a single command.

It will also tweak the UI, disable telemetry, uninstall pre-installed Windows apps and install all your favourite softwares.

Of course this personal repository is configured to be adapter on my specific needs, but you are free to fork it and [customize it](customization.md) as you wish.

## Set-up

From a powershell console, as an Administrator, just launch the following command:

`Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/SirAmonThe1/Win-10-Setup/master/Win-10-BoxStarter.ps1'))`

## Customization

Please refer to [customization](customization.md) to discover how to configure your personal set-up script.

## Features

* Disable the specified Windows services
* Remove the damn pre-installed Windows Apps (goodbye Candy Crush Saga)
* Enable Developer Mode
* Tweak the taskbar for multi-monitor configurations
* Remove XPS and Fax services
* Install your software from Chocolately in background
* Restore your backed-up Start layout
* Restore a back-up of home folder