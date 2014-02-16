backup-advanced
===============

This script is a universal backup script for sites using content management system (CMS) such as MediaWiki, Joomla and WordPress meant to be run daily using crontab. This script creates a copy of both database and files.

The basic idea of the script is to store daily versions of the site for a week backwards. Although, the first backup of each month will be saved permanently. This means that you should create "cyclic" and "monthly" directories in the directory meant to contain the backups.

The script is very simple and meant to be a base or sceleton when creating a backup script. Anyway, it also works as is. Just fill in the correct backup information in these quite self-explanatory variables. This script is published in public domain so feel free to modify it to fit your needs! The base is written by Tom Himanen (tom.himanen [at] gmail.com).