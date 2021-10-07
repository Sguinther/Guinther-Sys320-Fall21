#!/bin/bash


# Script for local security checks


function checks() {


	if [[ "$2" != "$3" ]]
	then
		echo "The $1 is not compliant. The current policy should be: $2. The current value is $3"
	else
		echo "The $1 is compliant. Current value is $3" 
	fi
}

#check password max days policy
pmax=$(egrep -i '^PASS_MAX_DAYS' /etc/login.defs | awk ' {print $2} ')
# check for password max

checks "Password Max Days" "365" "${pmax}"

#check pass min days between                               changes
pmin=$(egrep -i '^PASS_MIN_DAYS' /etc/login.defs | awk ' { print $2 } ' )
checks "password Min Days" "14" "${pmin}"

#Warn Age
pwarn=$(egrep -i '^PASS_WARN_AGE' /etc/login.defs | awk ' { print $2 } ' ) 
checks "Password Warn Age" "7" "${pwarn}"

# check SSH UsePam
checkSSHPAM=$(egrep -i "^UsePAM" /etc/ssh/sshd_config | awk  ' { print $2 } ' )
checks "SSH UsePAM" "yes" "${checkSSHPAM}"

# Check permissions on users home directory

echo ""
for eachDir in $(ls -l /home | egrep "^d" | awk ' { print $3 } ' )
do

	chDir=$(ls -ld /home/${eachDir} | awk ' { print $1 } ')
	checks "Home directory ${eachDir}" "drwx------" "${chDir}"
done



#ls -ld /home/ |egrep '^d' | awk ' { print $3 } ' 
