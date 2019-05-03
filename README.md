# wordpress_randompass
Sets random passwords for admin users on all WordPress installations on Linux server

To run just download and start the shell script. Can edit this line in it if you don't use admin as the administrative username on your server:

	mysql -e "use $database; update wp_users set user_pass = MD5('$random') where user_login = 'admin';" -u $username -p$password

just change the user_login = 'admin' to whatever you use. 
