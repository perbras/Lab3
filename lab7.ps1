<#
    Powershell Lab 7
    Manipulate users, OUs, Groups, and group membership
    Date: Apr 7 2020, Week 13
    Created by: Brandon Perez
#>
Clear-Host
function Show-Menu
{
    param (
        [string]$Title = 'My Menu'
    )
    Clear-Host
    Write-Host "choose from the following Menu Items:"
    
    Write-Host "A: View one OU `t`t`t B. View all OUs"
    Write-Host "C. View one group `t`t D. View all groups"
    Write-Host "E. View one user `t`t F. view all Users"
    Write-Host "`n"
    Write-Host "G. Create one OU `t`t H. Create one group"
    write-host "I. Create one user `t`t J. Create users from csv file"
    write-host "`n"
    write-host "k. Add user to group `t L. Remove user from group"
    Write-Host "`n"
    Write-Host "M. Delete one group `t N. Delete one user"
    Write-Host "`n"
    Write-Host "Enter anything other than A - N to quit"
}
do
 {
     Show-Menu
     $selection = Read-Host "Please make a selection"
     switch ($selection)
     {
         'A' {
             $OU = read-host "Name of OU"
             Get-ADOrganizationalUnit -LDAPFilter "(name=$OU*)" | Format-Table name, distinguishedname
             Read-Host "Press Enter to continue..."
         } 'B' {
             Get-ADOrganizationalUnit -Filter "*" | Format-Table name, distinguishedname
             Read-Host "Press Enter to continue..."
         } 'C' {
             $Group = Read-Host "Name of Group"
             Get-ADGroup -LDAPFilter "(name=$Group*)" | Format-Table name, groupscope, groupcategory
             Read-Host "Press Enter to continue..."
         } 'D' {
             Get-ADGroup -Filter "*" | Format-Table name, groupscope, groupcategory
             Read-Host "Press Enter to continue..."
         } 'E' {
             $User = Read-Host "Name of User"
             Get-ADUser -LDAPFilter "(name=$User*)" | Format-Table name, distinguishedname
             Read-Host "Press Enter to continue..."
         } 'F' {
             Get-ADUser -Filter "*" | Format-Table name, distinguishedname, firstname, lastname
             Read-Host "Press Enter to continue..."
         } 'G' {
             $_OU2 = read-host "Name of OU to create"
             New-ADOrganizationalUnit -Name "$_OU2" -path "DC=adatum,DC=com"
             Get-ADOrganizationalUnit -LDAPFilter "(name=$_OU2*)" | Format-Table name, distinguishedname
             Read-Host "Press Enter to continue..."
         } 'H' {
             $_Group2 = Read-Host "name of Group to create"
             New-ADGroup "$_Group2" -GroupCategory Security -GroupScope Global -path "CN=Users,DC=adatum,DC=com"
             Get-ADGroup -LDAPFilter "(name=$_Group2*)" | Format-Table name, groupscope, groupcategory
             Read-Host "Press Enter to continue..."
         } 'I' {
             $name = Read-Host "Name?"
             $pass = Read-Host "$name's Password?"
             $password = ConvertTo-SecureString -String $pass -AsPlainText -Force
             $first = Read-Host "$name's first name?"
             $last = Read-Host "$name's last name?"
             $city = Read-Host "$name's city?"
             $state = Read-Host "$name's state?"
             $zipcode = Read-Host "$name's zipcode"
             $company = Read-Host "$name's company"
             $division = Read-Host "$name's division?"
             $userparams = @{Name = $name;
                                samAccountName = $name;
                                UserPrincipleName = $name;
                                givenname = $first;
                                Surname = $last;
                                city = $city;
                                state = $state;
                                company = $company;
                                division = $division;
                                enabled = $true;}
            New-ADUser @userparams -AccountPassword $password


             
             Read-Host "Press Enter to continue..."
         } 'J' {
             Read-Host "Press Enter to continue..."
         } 'K' {
             $addgroup = Read-Host "group that will gain user"
             $adduser = Read-Host "User that will be added"
             Add-ADGroupMember -Identity "$addgroup" -Members "$adduser"
             Get-ADGroupMember -Identity "$addgroup" | Format-Table samaccountname, distinguishedname
             Read-Host "Press Enter to continue..."
         } 'L' {
             $lessgroup = Read-Host "Group that will lose a user"
             Get-ADGroupMember -Identity "$lessgroup" | Format-Table samaccountname, distinguishedname
             $del = Read-Host "which user should be deleted"
             $name = Read-Host "$del's name"
             Remove-ADUser -Identity "$name"
             Get-ADGroupMember -Identity "$lessgroup" | Format-Table samaccountname, distinguishedname
             Read-Host "Press Enter to continue..."
         } 'M' {
             $delgroup = read-host "what group will be deleted"
             Remove-ADGroup -Identity "$delgroup"
             Get-ADGroup -Filter "*" | Format-Table name, groupscope, groupcategory
             Read-Host "Press Enter to continue..."
         } 'N' {
             $deluser = Read-Host "what user will be deleted"
             Remove-ADUser -Identity "$deluser"
             Get-ADUser -Filter "*" | Format-Table name, distinguishedname
             Read-Host "Press Enter to continue..."
         }
     }
     
 }
 until ($selection -eq 'q')