#!/bin/bash

##########
# CONFIG #
##########

# MySQL login information
mysql_username=""
mysql_user_password=""
mysql_db_name=""

# Site address will be included in the file name of the backup, so
# basically it can be anything. This is just an identifier.

#site_address="example.com"
site_address=""

# Absolute path to the directory in which the backups will be stored.
# The path is defined without the trailing slash. See the example below: 

#dir_for_backups="/home/user/backups"
dir_for_backups=""

# The absolute location of the files of the site to be backed up without
# the trailing slash. See the example below:

#dir_to_be_backed_up="/home/user"
dir_to_be_backed_up=""

#########
# LOGIC #
#########

# Create the backup directories if needed
[ ! -d ${dir_for_backups} ]         && mkdir ${dir_for_backups}
[ ! -d ${dir_for_backups}/monthly ] && mkdir ${dir_for_backups}/monthly
[ ! -d ${dir_for_backups}/cyclic ]  && mkdir ${dir_for_backups}/cyclic

mysqldump       -u${mysql_username} -p${mysql_user_password} \
                ${mysql_db_name} | gzip > \
                ${dir_for_backups}/${site_address}_db_$(date +%y%m%d).sql.gz

tar cjf         ${dir_for_backups}/${site_address}_files_$(date +%y%m%d).tbz \
                --exclude ${dir_for_backups} \
                ${dir_to_be_backed_up}

if [ $(date +%d) = 01 ]; then
                cp ${dir_for_backups}/${site_address}_db_$(date +%y%m%d)*.tbz \
                ${dir_for_backups}/monthly/
fi 

mv              ${dir_for_backups}/${site_address}_files_$(date +%y%m%d).tbz \
                ${dir_for_backups}/cyclic/${site_address}_files_$(date +%a).tbz

mv              ${dir_for_backups}/${site_address}_db_$(date +%y%m%d).sql.gz \
                ${dir_for_backups}/cyclic/${site_address}_db_$(date +%a).sql.gz
