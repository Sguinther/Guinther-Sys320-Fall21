#storyline review security event log

$myDir = "C:\Users\champuser\Desktop\"

#list event logs
Get-EventLog -list

#get keyword
$key = Read-host -Prompt "select keyword to search for"

#create a promt to allow user to selecxt the log to view
$readlog = Read-host -Prompt "Please select a log to review from the list above" 

#print the results for the log
Get-EventLog -LogName $readlog -Newest 40 | where {$_.Message -ilike $key } | export-csv -NoTypeInformation 
-Path "$myDir\securityLogs.csv"




