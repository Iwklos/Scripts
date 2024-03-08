
$Key="MDRmZWZiODZlMTk4NTMxNjg3ODMxMTgwM2Q0MGE0OTk2NGFlYmVjMzBlYmEyOTVkZjgwMWYxNjUxOGRkOTBmYjo="
$Headers = @{
    Authorization = "Basic $Key";
}

$OS = (Get-ComputerInfo).OsProductType

if ($OS = "WorkStation"){
    $Body = '{
        "params": {
      
          "packageName": "$NINJA_ORGANIZATION_NAME Client"
      },
        "jsonrpc": "2.0",
        "method": "getInstallationLinks",
        "id": "1"
     }  '
 }
else {
    $Body = '{
        "params": {
      
          "packageName": "$NINJA_ORGANIZATION_NAME Server"
      },
        "jsonrpc": "2.0",
        "method": "getInstallationLinks",
        "id": "1"
     }  '
}

$list = Invoke-RestMethod -Uri "https://cloud.gravityzone.bitdefender.com/api/v1.0/jsonrpc/packages" -Headers $Headers -Method "POST" -ContentType "application/json" -Body $Body

$i = $list.result | Out-String

$a = $i.Split("`n")

foreach($t in $a){
    if ($t.Contains("fullKitWindowsX64")){
        $url = $t.TrimStart("fullKitWindowsX64        : ")
    }
}


Invoke-WebRequest $url -Headers $Headers -OutFile C:\temp
Start-Process -FilePath "C:\temp\*epskit*.exe" /quiet
