# Isaiah Klosterman, StudentID: 010467788

$sourceFiles = .\Requirements1.zip
$Date = Get-Date

while ($input != 5) {
    
    $input = read-host()


    switch($input){
        1{
            foreach($sourceFile in (Get-ChildItem -filter '*.zip'))
            {
                # Read contents of requirements zip file, filter, format and output to daily log file
                [IO.Compression.ZipFile]::OpenRead($sourceFile.FullName).Entries.FullName -like "*.log" | %{ "$Date $_" } | Add-Content -Path DailyLog.txt
        }
    }
        2{}
        3{
            $cpuTime = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue
            $availMem = (Get-Counter '\Memory\Available MBytes').CounterSamples.CookedValue
            write-output 'CPU: ' + $cpuTime.ToString("#,0.000") + '%, Avail. Mem.: ' + $availMem.ToString("N0") + 'MB (' + (104857600 * $availMem / $totalRam).ToString("#,0.0") + '%)'
        }
        4{}
        5{}
    }
}