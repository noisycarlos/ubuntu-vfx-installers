#!/bin/bash

current_script=$(basename "$0")

for file in *.sh; do
  if [ "$file" != "$current_script" ]; then
    bash ./${file}
  fi
done
