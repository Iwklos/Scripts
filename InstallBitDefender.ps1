
$Key="MDRmZWZiODZlMTk4NTMxNjg3ODMxMTgwM2Q0MGE0OTk2NGFlYmVjMzBlYmEyOTVkZjgwMWYxNjUxOGRkOTBmYjo="
$Headers = @{
    Authorization = "Basic $Key";
}
$Body = '{
    "params": {
      
      "packageName": "DBS Test"
  },
    "jsonrpc": "2.0",
    "method": "getInstallationLinks",
    "id": "1"
 }  '



$list = Invoke-RestMethod -Uri "https://cloud.gravityzone.bitdefender.com/api/v1.0/jsonrpc/packages" -Headers $Headers -Method "POST" -ContentType "application/json" -Body $Body

Write-Output $list