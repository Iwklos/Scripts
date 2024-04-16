
# Get last error type for try-catch
$Error[0].Exception.GetType().FullName

# append to command to change non-terminating errors to terminating errors
-ErrorAction Stop