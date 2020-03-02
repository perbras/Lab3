<#

Purpose: 3rd Powershell lab. practice use of:
            Here-Strings
            Piping commands 
            writing and reading files
            conditional logic 

Author: Brandon Perez
File: Lab3Files.ps1
Date: February 24, 2020

#>

Clear-Host

Set-Location $env:USERPROFILE

Get-ChildItem -Path C:\Users\perbras -filter *.txt | Format-Table -property name, length

$menu = @"
what do you want to do?:
    1. Write a contact entry to a file
    2. Display all files last written to after a given date
    3. Read a specified text file 
"@
$menu
$choice = Read-Host "type in 1,2, or 3"

if ($choice -eq 1) {
    Write-Output "you chose to write a contact entry to a file"
    $fullname = read-host "Enter full name"
    $phonenumber = Read-Host "enter phone nuber"
    $email = Read-Host "enter email address"
    $filename = Read-Host "file name"
    Add-Content -Path $filename -value $fullname
    Add-Content -Path $filename -Value $phonenumber
    Add-Content -Path $filename -Value $email
    Add-Content -Path $filename -Value ""
    

}
elseif ($choice -eq 2) {
    Write-Output "Display all files last written to after a given date"
    $date = Read-Host "Earliest date of files to display"
    Get-ChildItem | Where-Object {$_.LastWriteTime -ge $date}| Sort-Object -Property lastwritetime | Format-Table -Property name, lastwritetime
}elseif ($choice -eq 3) {
    Write-Output "Read a specified text file"
    $file = Read-Host "name of file"
    $exists = test-path -Path $file
    if ($exists -eq $true) {Get-Content $file}
    else {Write-Host "The file $file does not exist."}    
    

}
else {
    Write-Output "you picked else "
    Write-Output "$env:username entered an invalid response on $env:computername"
}
 