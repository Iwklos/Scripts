# get sage pdf converter folder

Set-Location "HKCU:"

$main = Get-ChildItem -path "*" -Recurse -Include *sage*pdf*converter*

# find and delete folders for jobs and locks

Remove-Item "$main\Jobs" -Force -Recurse

Remove-Item "$main\Locks" -Force -Recurse# get sage pdf converter folder

Set-Location "HKCU:"

$main = Get-ChildItem -path "*" -Recurse -Include *sage*pdf*converter*

# find and delete folders for jobs and locks

Remove-Item "$main\Jobs" -Force -Recurse

Remove-Item "$main\Locks" -Force -Recurse