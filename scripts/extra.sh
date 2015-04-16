#This is stuff that will eventually go in newsite.sh. Removed for troubleshooting.

# Rename the project files
#mv base_project-7.x-1.x ../../$1_custom
mv ../../$1_custom/project.make ../../$1_custom/$1.make
mv ../../$1_custom/project_custom ../../$1_custom
mv ../../$1_custom/$1_custom/project_custom.info ../../$1_custom/$1_custom/$1_custom.info

# Initialize the project git repository
git --git-dir=../../$1_custom init
# Add the remote as origin
git --git-dir=../../$1_custom remote add origin $project_custom_repo
# Make the initial commit of the project files
git --git-dir=../../$1_custom commit -a -m "Automated initial commit of project files" --author="Aviator Monkey <jr@jackonsriver.com>"

#Download the theme templates
wget https://github.com/sheena-d/base_themes/archive/7.x-1.x.zip
unzip 7.x-1.x.zip
rm 7.x-1.x.zip

# Rename the theme files
mv base_themes-7.x-1.x ../../$1_themes
mv ../../$1_themes/project ../../$1_themes/$1
mv ../../$1_themes/$1/project.info ../../$1/$1.info

# Initialize the project themes git repository
git --git-dir=../../$1_themes init
# Add the remote as origin
git --git-dir=../../$1_themes remote add origin $project_themes_repo
git --git-dir=../../$1_themes commit -a -m "Automated initial commit of project themes" --author="Aviator Monkey <jr@jackonsriver.com>"

