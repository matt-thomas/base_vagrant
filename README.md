# Local Springboard Development Environment

This is a LAMP Virtual Machine with customizations for doing local development and testing with Springboard.

# Getting Started

1. [Install Virtualbox.](https://www.virtualbox.org/wiki/Downloads) This also works with VMWare Fusion if you have it and the Vagrant integration. Virtualbox is the free solution.
2. [Install Vagrant.](https://www.vagrantup.com/downloads.html)
3. Clone this repo.
4. `cp config.yml.dist config.yml`
5. Edit config.yml. This file contains client and developer specific settings.
  - Domain name must match *.local for the wildcard SSL cert.
  - Docroot should point to your local drupal install.
  - If you need to symlink the springboard_modules repo, see below for how to add the `synced_folders` setting.
6. `vagrant up` An admin password will be needed to add NFS mounts.
7. Edit you host's `/etc/hosts` file to include the IP and domain name from config.yml.
8. Run `./scripts/add-symlinks.sh` to add symlinks to local.settings.php and the files directory within the codebase. It's expected that your normal settings.php file will include local.settings.php in the same directory. If that's not the case or you don't have a settings.php, create one under sites/default/ that contains:

````
<?php
@include 'local.settings.php';
?>
````

If you're symlinking springboard_modules repo into your drupal repo, also run `./scripts/symlink-springboard-modules.sh` to create a symlink for `springboard_modules`. See below for more info on correctly getting this working.

9. Run `./scripts/install-fresh-springboard.sh` This will provide a login link at the end.
10. Run `./scripts/run-tests.sh` to run the Springboard specific simpletests. Note that the test run will fail on the sustainer tests because the sustainer key is hardcoded in local.settings.php. Everything else should pass.

## vrush

The `vrush` script will run drush as the apache user inside the VM and use the correct drush alias.

````
./vrush status
./vrush cc all
./vrush sql-cli
````
and so on.

## Advanced

### Symlinking to the springboard_modules repo

If you normally symlink to the springboard_modules repo from the main drupal repo you'll have a few extra steps.

You'll need to set up your host file structure so that springboard_modules and the docroot are sibling directories.

````
your_workspace/
  docroot/
    sites/
      all/
        modules/
          contrib/
          custom/
  local-springboard/
  springboard_modules/

````

Then you need to add the springboard_modules directory to the config.yml so it will show up in the VM.

In this example, config.yml should include:

````
synced_folders:
  - source: ../springboard_modules
    destination: /springboard_modules
````

Make sure to do that before you run `vagrant up`. Then, after the VM is running, run `./scripts/symlink-springboard-modules.sh` so the symlink will be created.

The results should be:

````
Host:
your_workspace/docroot/sites/all/modules/springboard -> ../../../../springboard_modules

Guest:
/docroot/sites/all/modules/springboard -> ../../../../springboard_modules
````

## Coming soon
 - Import/export db scripts.
 - Import/export files dir scripts.
 - The ability to download Springboard packages, db dumps, and files dirs as artifacts from other environments and clients.
 - Piece the above together so sync site is one command/script.
 - Make a workaround for sustainers key being locked and causing tests to fail.
 - Put the apache logs inside /vagrant so they're available to the host.
 - Consider adding tools like mailcatcher, xdebug/xhprof, drush extensions, and anything else depending on demand.
