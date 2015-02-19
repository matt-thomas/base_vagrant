#!/bin/bash

echo "Symlinking /docroot/sites/all/modules/springboard to ../../../../springboard_modules"

vagrant ssh -c "cd /docroot/sites/all/modules && ln -nfs ../../../../springboard_modules springboard ; ls -lah"

echo "This symlink should exist above and should work on both the host and guest if set up correctly."
