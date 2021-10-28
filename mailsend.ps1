#storyline send an email

# body of email

$msg = "hello!"

write-host -BackgroundColor Red -ForegroundColor white $msg

$email = "sam.guinther@mymail.champlain.edu" 


#to address

$toemail = "deployer@csi-web"

#send mail
Send-MailMessage -From $email -to $toemail -Subject "Oi what it is" -body $msg -SmtpServer 192.168.6.71


