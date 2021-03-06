#!/bin/bash

set -x

cd $GITHUB_WORKSPACE

/usr/local/bin/treefmt $*
git diff &> p.patch
# non-zero => empty, no diff, zero => there is a diff
[ -s p.patch ]
echo ::set-output name=exit-code::$?
rm p.patch
