<# Create a “switch” statement that continues to prompt a user by doing each of the following activities, until a user presses key 5:

1.  Using a regular expression, list files within the Requirements1 folder, with the .log file extension and redirect the results to a new file called “DailyLog.txt” within the same directory without overwriting existing data. Each time the user selects this prompt, the current date should precede the listing. (User presses key 1.)

2.  List the files inside the “Requirements1” folder in tabular format, sorted in ascending alphabetical order. Direct the output into a new file called “C916contents.txt” found in your “Requirements1” folder. (User presses key 2.)

3.  List the current CPU and memory usage. (User presses key 3.)

4.  List all the different running processes inside your system. Sort the output by virtual size used least to greatest, and display it in grid format. (User presses key 4.)

5.  Exit the script execution. (User presses key 5.)
#>

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
                # List processes and format
                $o = Get-Process | sort vm | select name, vm | Out-Host
            
            }
            # escape from loop if selected
            5 { Break }
        }
    }
}
# if error occurs output text
catch [System.OutOfMemoryException] {
    "Out of memory"
}
