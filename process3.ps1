# Stoeylibe: view the event logs check for valid log print the results. 
function select_log() {
    cls
    # list all event logs
    $thelogs = Get-EventLog -List | select log
    $thelogs | out-Host

    #array
    $arrlog = @()

    foreach ($templog in $thelogs) {
        #add each to the array
        #stored as a hashtable in the format:
        # @{Log=LOGNAME}
        $arrlog += $templog
    }
    #$arrlog[0]

    #prompt user for the log to view or quit 
    $readlog = read-host -Prompt "please enter a log from the list above or q to quit the program"
    
    if ($readlog -match "^[qQ]$") {

        #stop script
        break
    }

    log_check -logToSearch $readlog

}

function log_check() {

    #argument passed to the function  (string in this case)
    Param([string]$logToSearch)

    #Format the user input
    $thelog = "^@{log=" +$logToSearch + "}$"

    #search array for the exact hashtable string
    if ($arrLog -match $thelog) {

        write-host -BackgroundColor Green -ForegroundColor white "please wait, retrieving log entries."
        sleep 2

        #call function to view log
        view_log -logToSearch $logToSearch

    } else {

        write-host -BackgroundColor red -ForegroundColor white "The log specefied doesn't exist"

        sleep 2

        select_log
    }
    
}

function view_log() {

    cls

    #user provided value
    #Param([string]$logToSearch)

    #get em
    Get-EventLog -Log $logToSearch -Newest 10 -after "1/18/2020"

    #pause the screen and wait until the user is ready to proceed
    read-host -Prompt "press enter when done"

    select_log

    

}

select_log