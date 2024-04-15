<#
Write the PowerShell commands in “Restore-AD.ps1” that perform all the following functions without user interaction:

1.  Check for the existence of an Active Directory Organizational Unit (OU) named “Finance.” Output a message to the console that indicates if the OU exists or if it does not. If it already exists, delete it and output a message to the console that it was deleted.

2.  Create an OU named “Finance.” Output a message to the console that it was created.

3.  Import the financePersonnel.csv file (found in the attached “Requirements2” directory) into your Active Directory domain and directly into the finance OU. Be sure to include the following properties:

•   First Name

•   Last Name

•   Display Name (First Name + Last Name, including a space between)

•   Postal Code

•   Office Phone

•   Mobile Phone

4.  Include this line at the end of your script to generate an output file for submission:

Get-ADUser -Filter * -SearchBase “ou=Finance,dc=consultingfirm,dc=com” -Properties DisplayName,PostalCode,OfficePhone,MobilePhone > .\AdResults.txt
#>

# Isaiah Klosterman, StudentID: 010467788
$file = Import-Csv financePersonnel.csv
$i = 0

# Check if OU is present
try {
    
    Remove-ADOrganizationalUnit -Identity "OU=Finance,DC=consultingfirm,DC=com" -Recursive -Confirm:$false
    Write-Output "OU Finance was found and deleted"
}
# If OU is not present then inform user
catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException] {
    Write-Output "OU Finance was not found"

}
# After checking OU above create new OU
finally {
    New-ADOrganizationalUnit -Name "Finance" -ProtectedFromAccidentalDeletion $false
    Write-Output "OU Finance Created"
}


# Loop through each row and gather user information
ForEach ($user in $file) {
    
    #Organize Parameters for users
    $splat = @{
        
        # Map parameters for AD Users
        Path = "OU=Finance,DC=consultingfirm,DC=com"
        GivenName = $file.First_Name[$i]
        Surname = $file.Last_Name[$i]
        DisplayName = "$GivenName $Surname"
        Name = $file.samAccount[$i]
        PostalCode = $file.PostalCode[$i]
        OfficePhone = $file.OfficePhone[$i]
        MobilePhone = $file.MobilePhone[$i]
    }

    

    # Create new AD user for each user in CSV file
    New-ADUser @splat

    #Iterate to next integer for next loop
    $i = $i + 1
}

# End result verification
Get-ADUser -Filter * -SearchBase “ou=Finance,dc=consultingfirm,dc=com” -Properties DisplayName,PostalCode,OfficePhone,MobilePhone > .\AdResults.txt