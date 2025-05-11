Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

function Check-Internet {
    return Test-Connection -ComputerName 8.8.8.8 -Count 2 -Quiet
}

function Run-MAS_AIO {
    Start-Process powershell -ArgumentList "-Command irm https://get.activated.win | iex"
}

function Run-ChrisTitus {
    Start-Process powershell -ArgumentList "-Command irm https://christitus.com/win | iex"
}

function Open-Edge {
   Start-Process powershell -ArgumentList "-Command irm https://raw.githubusercontent.com/VMCBhargav/powerscript/refs/heads/main/Win11debloater.ps1 | iex"
}

function Cleanup-And-Exit {
    Get-ChildItem "C:\Windows\Temp","$env:TEMP" -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
    $form.Close()
}

# Create Form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Bhargav's Script Menu"
$form.Size = New-Object System.Drawing.Size(400,300)
$form.StartPosition = "CenterScreen"

# Create Buttons
$button1 = New-Object System.Windows.Forms.Button
$button1.Text = "1. MAS_AIO Script"
$button1.Location = New-Object System.Drawing.Point(50,30)
$button1.Size = New-Object System.Drawing.Size(300,40)
$button1.Add_Click({ Run-MAS_AIO })

$button2 = New-Object System.Windows.Forms.Button
$button2.Text = "2. Chris Titus Script"
$button2.Location = New-Object System.Drawing.Point(50,80)
$button2.Size = New-Object System.Drawing.Size(300,40)
$button2.Add_Click({ Run-ChrisTitus })

$button3 = New-Object System.Windows.Forms.Button
$button3.Text = "3. VMC Script (Open Edge)"
$button3.Location = New-Object System.Drawing.Point(50,130)
$button3.Size = New-Object System.Drawing.Size(300,40)
$button3.Add_Click({ Open-Edge })

$button4 = New-Object System.Windows.Forms.Button
$button4.Text = "4. Exit and Clean Temp"
$button4.Location = New-Object System.Drawing.Point(50,180)
$button4.Size = New-Object System.Drawing.Size(300,40)
$button4.Add_Click({ Cleanup-And-Exit })

# Check Internet
if (Check-Internet) {
    $form.Controls.AddRange(@($button1, $button2, $button3, $button4))
    [System.Windows.Forms.Application]::Run($form)
} else {
    [System.Windows.Forms.MessageBox]::Show("Internet is OFF. Opening Network Settings...", "Connection Error", "OK", "Error")
    Start-Process "ncpa.cpl"
}
