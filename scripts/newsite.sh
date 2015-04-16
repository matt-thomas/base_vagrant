#!/bin/sh

# project_name=${project_name}
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
rm 7.x-1.x.zip

# Rename the project files
mv ../../base_project-7.x-1.x ../../${project_name}_custom
mv ../../${project_name}_custom/project.make ../../${project_name}_custom/${project_name}.make
mv ../../${project_name}_custom/project_custom ../../${project_name}_custom/${project_name}_custom
mv ../../${project_name}_custom/${project_name}_custom/project_custom.info ../../${project_name}_custom/${project_name}_custom/${project_name}_custom.info

# # Initialize the project git repository
git init ../../${project_name}_custom
# # Add the remote as origin
git --git-dir=../../${project_name}_custom/.git remote add origin $project_custom_repo
# # Make the initial commit of the project files
git --git-dir=../../${project_name}_custom/.git commit -a -m "Automated initial commit of project files" --author="Aviator Monkey <jr@jackonsriver.com>"

#Download the theme templates
wget -q https://github.com/sheena-d/project_themes/archive/7.x-1.x.zip
unzip -q 7.x-1.x.zip -d ../../
rm 7.x-1.x.zip

# Rename the theme files
mv ../../project_themes-7.x-1.x ../../${project_name}_themes
mv ../../${project_name}_themes/project ../../${project_name}_themes/${project_name}
mv ../../${project_name}_themes/${project_name}/project.info ../../${project_name}_themes/${project_name}/${project_name}.info

# Initialize the project themes git repository
git init ../../${project_name}_themes
# Add the remote as origin
git --git-dir=../../${project_name}_themes/.git remote add origin $project_themes_repo
git --git-dir=../../${project_name}_themes/.git commit -a -m "Automated initial commit of project themes" --author="Aviator Monkey <jr@jackonsriver.com>"

