
$Address = Read-Host "Please enter Inform URL/IP"

echo y | plink -ssh -pw "ubnt" ubnt@192.168.1.20 "exit"

plink -pw "ubnt" -ssh ubnt@192.168.1.20 -batch "mca-cli-op set-inform set-inform ${Address}"