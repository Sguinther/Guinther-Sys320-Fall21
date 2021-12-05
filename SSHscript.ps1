# Login to a remote SSH server
New-SSHSession -ComputerName '192.168.4.22' -Credential (Get-Credential sys320)
cls

<#
while ($True) {

    #Netstat -anp --inet ///a shows all / n shows only ip addresses not hostnames / p shows process id / inet shows ipv4 sockets
    #add a prompt to run commands
    $the_cmd = read-host -Prompt "Please enter a command"

    # Run command on remote server
    (Invoke-SSHCommand -index 0 $the_cmd).Output

    }

#>
Set-SCPFile -Computername '192.168.4.22' -Credential (Get-Credential sys320)
-RemotePath '/home/sys320' -LocalFile '.\tedx.jpeg'