#!/bin/sh 


echo "::configure-defaults treefmt-action::"


# connections
git config --global http.postBuffer 2048M
git config --global http.maxRequestBuffer 1024M
git config --global core.compression 9

git config --global ssh.postBuffer 2048M
git config --global ssh.maxRequestBuffer 1024M

git config --global pack.windowMemory 256m 
git config --global pack.packSizeLimit 256m

# CI Bot
GITHUB_ACTOR=SUTBot
git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
git config --global --add safe.directory /github/workspace


# diffing
git config --global merge.renameLimit 999999
# min. value = 33440
git config --global diff.renameLimit 33440
git config --global diff.algorithm patience

# submodules
git config --global diff.submodule log
git config --global status.submoduleSummary true
git config --global fetch.recurseSubmodules true
git config --global push.recurseSubmodules on-demand
