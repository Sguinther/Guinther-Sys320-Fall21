#! /bin/bash

#parse apache log
#101.236.44.127 - - [24/Oct/2017:04:11:14 -0500] "GET / HTTP/1.1" 200 225 "-" "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.94 Safari/537.36"


#read in file

#arguments using the position, they start at $1
APACHE_LOG="$1"

#check if fle exists
if [[ ! -f ${APACHE_LOG} ]]
then
	echo "Please specify the path to a log file"
	exit 1
fi

#looking for web scanners
sed -e "s/\[//g" -e "s/\"//g" ${APACHE_LOG} | \
egrep -i "test|shell|echo|passwd|select|phpmyadmin|setup|admin|w00t" | \
awk ' BEGIN { format = "%-15s %-20s %-6s %-6s %-5s %s\n" 
		printf format, "IP", "Date", "Method", "Status", "Size", "URI"
		printf format, "--", "----", "------", "------", "----", "---"}
}
{ printf format, $1, $4, $6, $9, $10, $7 }'
