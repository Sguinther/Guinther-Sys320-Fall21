# Use the Get-WMIobject cmdlet
#Get-WMiobject -Class Win32_service | select Name, PathName, ProcessId
#get-wmiobject -list | where { $_.Name -ilike "Win32_[n-z]*" } | sort-object
#Get-wmiObject -Class Win32_Account | get-member

# Task: Grab the network adapter informattion using the WMI class
# Get the IP address, default gateway, and DNS server
# Bonus: Get the dhcp server
# Post code to pineapple
# run code using screen recorder

#Get-WMiobject -Class Win32_service | select Name, PathName, ProcessId
#get-wmiobject -list | where { $_.Name -ilike "Win32_network*" } | sort-object
Get-WmiObject -class win32_networkadapterconfiguration 



