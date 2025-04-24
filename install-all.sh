#!/bin/bash

current_script=$(basename "$0")

for file in *.sh; do
  if [ "$file" != "$current_script" ]; then
    sh ./${file}
  fi
done
