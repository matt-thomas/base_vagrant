# Local Springboard Development Environment

1. Install Virtualbox. This also works with VMWare Fusion if you have it.
2. Install Vagrant.
3. Clone this repo.
4. cp config.yml.dist config.yml
5. Edit config.yml.
  - Domain name must match *.local for the wildcard SSL cert.
  - Docroot should point to your local drupal install.
  - Add synced folders to make them available inside the VM. Mainly used to symlink inside the VM when your docroot consists of symlinks.
6. vagrant up
7. Edit you host's /etc/hosts file to include the IP and domain name from config.yml.
8. ./scripts/add-symlinks.sh to add symlinks to local.settings.php and the files directory within the codebase. It's expected that your normal settings.php file will include local.settings.php in the same directory. If that's not the case or you don't have a settings.php, create one under sites/default/ with


````
<?php
@include 'local.settings.php';
?>
````

9. ./scripts/install-fresh-springboard.sh
10. ./scripts/run-tests.sh

Note that the test run will fail on the sustainer tests because the sustainer key is hardcoded in local.settings.php. Everything else should pass.

## Synced folders syntax in config.yml

````
synced_folders:
  - source: ../springboard_modules
    destination: /springboard_modules
````

## Coming soon
 - Import/export db scripts.
 - Import/export files dir scripts.
 - The ability to download Springboard packages, db dumps, and files dirs as artifacts from other environment and clients.
 - Piece the above together so sync site is one command/script.
 - Make a workaround for sustainers key being locked and causing tests to fail.
