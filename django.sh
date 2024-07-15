#! /usr/bin/bash

clear

read -p "Create virtual environment:  " ROOT_DIR
mkdir $ROOT_DIR && cd $ROOT_DIR

virtualenv . && source bin/activate
clear

pip3 install django djangorestframework
clear

while true; do
	read -p "${ROOT_DIR} as project name? [Y/n]:  " yn
	case "$yn" in
	[Yy]*)
		django-admin startproject $ROOT_DIR
		break
		;;
	[Nn]*)
		read -p "Enter the project name: " PROJ_NAME
		django-admin startproject $PROJ_NAME
		break
		;;
	esac
done

ls -Art | tail -n 1 PROJ_NAME

clear
cd $PROJ_NAME

python3 manage.py migrate
clear

pip3 freeze >requirments.txt

echo "New project '${PROJ_NAME}' was created in '${ROOT_DIR}' directory."

while true; do
	read -p "Create an app? [Y/n]:  " yn
	case "$yn" in
	[Yy]*)
		read -p "Enter the app name: " APP_NAME
		python3 manage.py startapp $APP_NAME
		cd $APP_NAME
		touch urls.py forms.py
		mkdir static/ templates/
		echo "New app '${APP_NAME}' was created in '${PROJ_NAME}' project."
		break
		;;
	[Nn]*)
		echo "App was not created."
		break
		;;
	esac
done

deactivate
