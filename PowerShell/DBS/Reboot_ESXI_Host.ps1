$User = <User>
$Pswd = <Host Password>
$hostName = <Host>
$plinkoptions = " -v -pw $Pswd"
$cmd1 = ' reboot'
$remoteCommand = '"' + $cmd1 + '"'
$command = "Echo Yes| "+   plink + " " + $plinkoptions + " " + $User + "@" + $hostName + " " + $remoteCommand
$result = Invoke-Expression -command $command
$result