#Install BitDefender Script

#Change this to org name
$org = "$env:NINJA_ORGANIZATION_NAME"

#installation path
$fp = "C:\temp"
#Get os type
$OS = (Get-ComputerInfo).OsProductType

#API Key:
$Key="MDRmZWZiODZlMTk4NTMxNjg3ODMxMTgwM2Q0MGE0OTk2NGFlYmVjMzBlYmEyOTVkZjgwMWYxNjUxOGRkOTBmYjo="

#Request Headers
$Headers = @{
    Authorization = "Basic $Key";
}

#Request Body
if ($OS = "WorkStation"){
    $Body = '{
        "params": {
      
          "packageName": "replace_t Client"
      },
        "jsonrpc": "2.0",
        "method": "getInstallationLinks",
        "id": "1"
     }  ' | foreach {$_.replace('replace_t',$org)}
 }
else {
    $Body = '{
        "params": {
      
          "packageName": "replace_t Server"
      },
        "jsonrpc": "2.0",
        "method": "getInstallationLinks",
        "id": "1"
     }  ' | foreach {$_.replace('replace_t',$org)}
}




#API Request
$list = Invoke-RestMethod -Uri "https://cloud.gravityzone.bitdefender.com/api/v1.0/jsonrpc/packages" -Headers $Headers -Method "POST" -ContentType "application/json" -Body $Body

#Format and extract url
$i = $list.result | Out-String
$a = $i.Split("`n")
foreach($t in $a){
    if ($t.Contains("fullKitWindowsX64")){
        $url = $t.TrimStart("fullKitWindowsX64        : ")
    }
}

#Get Installation File
Invoke-WebRequest -Uri $url -Headers $Headers -OutFile $fp\BD.zip
Expand-Archive "$fp\BD.zip" -DestinationPath C:\temp
Start-Process -FilePath "$fp\*epskit*.exe" /quiet