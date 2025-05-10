# Check-InternetConnection.ps1



function Show-Menu {
    while ($true) {
        Clear-Host
        Write-Host "Internet is ON." -ForegroundColor Green
        Write-Host "====== MENU ======" -ForegroundColor Cyan
        Write-Host "1. MAS_AIO SCRIPT"
        Write-Host "2. Chris titus script"
        Write-Host "3. VMC Script"
        Write-Host "4. Exit"
        Write-Host ""

        $choice = Read-Host "Enter your choice (1-4)"

        switch ($choice) {
            "1" {
                irm https://get.activated.win | iex
                Start-Sleep -Seconds 2
            }
            "2" {
                try {
                    cls
                    Write-Host "This script may take  few seconds to run be patient." -ForegroundColor Yellow
                    Start-Sleep -Seconds 2
                    cls
                     powershell "irm https://christitus.com/win | iex"
                } catch {
                    Write-Host "Please run it manually" -ForegroundColor Red
                    echo "irm https://christitus.com/win | iex" | clip
                    Start-Sleep -Seconds 2
                }
            }
            "3" {
                try {
                    Start-Process "msedge"
                } catch {
                    Write-Host "Microsoft Edge not found. Make sure it's installed." -ForegroundColor Red
                    Start-Sleep -Seconds 2
                }
            }
            "4" {
                Write-Host "Exiting..." -ForegroundColor Yellow
                Get-ChildItem "C:\Windows\Temp","$env:TEMP" -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
                Start-Sleep -Seconds 10
                exit & cls
            }
            default {
                Write-Host "Invalid choice. Please try again." -ForegroundColor Red
                Start-Sleep -Seconds 2
            }
        }
    }
}

# Check Internet connection
$hostToPing = "8.8.8.8"
$pingResult = Test-Connection -ComputerName $hostToPing -Count 2 -Quiet

if ($pingResult) {
    Show-Menu
} else {
    Write-Host "Internet is OFF. Opening Network Connections..." -ForegroundColor Red
    Start-Process "ncpa.cpl"
}
