
# Isaiah Klosterman, StudentID: 010467788

$Date = Get-Date

# Do not end until 5 is selected
try {
    while ($i -ne 5) {
        
        # Get input selection
        $i = read-host -Prompt ("Enter Input (1-5)")


        switch ($i) {
            1 {
                # Iterate through the folder
                foreach ($var in dir) {

                    # Get log files in requirements file, filter, date and output to daily log file
                    if ($var.Name -like "*.log") {
                        $var | % { "$Date $_" } | Add-Content -Path DailyLog.txt
                    }
                }
            }
            2 {
                # Get names of entire files in requirements folder and output it to  C916contents file
                dir | Sort -Property Fullname | Format-Table >> C916contents.txt
            }
            3 {
                # Output CPU and Memory
                $cpuTime = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue
                $availMem = (Get-Counter '\Memory\Available MBytes').CounterSamples.CookedValue
                'CPU: ' + $cpuTime.ToString("#,0.000") + '%, Avail. Mem.: ' + $availMem.ToString("N0") + 'MB'
            }
            4 {
                # List processes formatted
                Get-Process | sort vm | select name, vm 
            
            }
            5 { Break }
        }
    }
}
catch [System.OutOfMemoryException] {
    "Out of memory"
}
