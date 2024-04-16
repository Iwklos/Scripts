<#
Write the PowerShell commands in a script named “Restore-SQL.ps1” that perform the following functions without user interaction:

1.  Check for the existence of a database named ClientDB. Output a message to the console that indicates if the database exists or if it does not. If it already exists, delete it and output a message to the console that it was deleted.

2.  Create a new database named “ClientDB” on the Microsoft SQL server instance. Output a message to the console that the database was created.

3.  Create a new table and name it “Client_A_Contacts” in your new database. Output a message to the console that the table was created.

4.  Insert the data (all rows and columns) from the “NewClientData.csv” file (found in the attached “Requirements2” folder) into the table created in part D3.

5.  Include this line at the end of your script to generate the output file SqlResults.txt for submission:

Invoke-Sqlcmd -Database ClientDB –ServerInstance .\SQLEXPRESS -Query ‘SELECT * FROM dbo.Client_A_Contacts’ > .\SqlResults.txt
#>

# Isaiah Klosterman, StudentID: 010467788

# Assign variables
$svr = "$(hostname)\SQLEXPRESS"
$file = Import-Csv NewClientData.csv
$db = "ClientDB"
$tb = "Client_A_Contacts"

# Check if DB is present and delete
try {
    Invoke-Sqlcmd -ServerInstance $svr -Query "ALTER DATABASE $db SET SINGLE_USER WITH ROLLBACK IMMEDIATE"
    Invoke-Sqlcmd -ServerInstance $svr -Query "Drop database $db" -ErrorAction Stop
    Write-Output "DB ClientDB was found and deleted"
}
# If DB is not present then inform user
catch [Microsoft.SqlServer.Management.PowerShell.SqlPowershellSqlExecutionException] {
    Write-Output "DB ClientDB was not found"

}
# After checking DB above create new DB
finally {
    Invoke-Sqlcmd -ServerInstance $svr -Query "Create database $db"
    Write-Output "ClientDB Database Created"
}

# Create and write csv data to the table 
Write-SqlTableData -InputData $file -ServerInstance $svr -DatabaseName $db -TableName $tb -SchemaName "dbo" -Force

# End result verification
Invoke-Sqlcmd -Database ClientDB –ServerInstance .\SQLEXPRESS -Query ‘SELECT * FROM dbo.Client_A_Contacts’ > .\SqlResults.txt