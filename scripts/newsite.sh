#!/bin/sh

# project_name=$1
# project_custom_repo=
# project_themes_repo=

echo "Enter a short name for your project. Ex. 'UNICEF'"
read project_name
echo $project_name

echo "Enter the URL of the EMPTY remote git repository for this project's modules."
echo "Use the format https://domain.com/path/to/repo.git"
read project_custom_repo
echo $project_custom_repo

echo "Enter the URL of the EMPTY remote git repository for this project's themes."
echo "Use the format https://domain.com/path/to/repo.git"
read project_themes_repo

# Create a stub project directory and makefile
# Download the project templates
echo "Downloading the project boilerplate"
wget -q https://github.com/sheena-d/base_project/archive/7.x-1.x.zip
unzip -q 7.x-1.x.zip -d ../../
#rm 7.x-1.x.zip
