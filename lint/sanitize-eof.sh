#!/usr/bin/env bash
# 
## sanitize-eof
# while IFS= read -rd '' f; do ... done iterates through the entries, safely handling filenames that include whitespace and/or newlines.
# tail -c1 < "$f" reads the last char from a file.
# read -r _ exits with a nonzero exit status if a trailing newline is missing.
# || echo >> "$f" appends a newline to the file if the exit status of the previous command was nonzero.
##
#
echo "[LINT]: Sanitizing recursively..."
git ls-files -z | while IFS= read -rd '' f; do tail -c1 < "$f" | read -r _ || echo >> "$f"; done
exit 0
