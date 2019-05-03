#!/bin/bash

db_info=$(find / -name wp-config.php | xargs -I {} egrep 'DB_NAME|DB_USER|DB_PASSWORD' {} | cut -d \' -f 4)

max=$(echo $db_info | tr -dc ' ' | wc -m)
max=$((max+1))

j=1
for i in `seq 1 3 $max`
do
	random=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
	database=$(echo $db_info | cut -d ' ' -f $j)
	j=$((j+1))
	username=$(echo $db_info | cut -d ' ' -f $j)
	j=$((j+1))
	password=$(echo $db_info | cut -d ' ' -f $j)
	j=$((j+1))
	url=$(mysql -e "use $database; select option_value from wp_options where option_name = 'siteurl' ;" -u $username -p$password | grep -v option_value)
	mysql -e "use $database; update wp_users set user_pass = MD5('$random') where user_login = 'admin';" -u $username -p$password
	echo "New password for $url is $random"
	echo
done
