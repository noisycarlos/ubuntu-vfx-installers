#!/bin/bash

app_name="DaVinci Resolve"

installer=$(find . -maxdepth 1 -type f -name 'DaVinci_Resolve_Studio_*_Linux.run')

if [ ! -f "$installer_path" ]; then
  echo "--- Skipping installation of ${app_name}, no installers found."
  exit 1
fi

version=$(echo ${installer} | sed -n 's/.\/DaVinci_Resolve_Studio_\([0-9.]*\)_Linux.run/\1/p')
echo "--- Installing ${app_name} version ${version}..."

sudo apt install libapr1 libaprutil1 libxcb-cursor0 libxcb-damage0
sudo SKIP_PACKAGE_CHECK=1 ${installer} -i -y

echo "--- Moving uneeded libraries..."

sudo mkdir /opt/resolve/libs/unneeded
sudo mv /opt/resolve/libs/libgio* /opt/resolve/libs/unneeded/
sudo mv /opt/resolve/libs/libglib* /opt/resolve/libs/unneeded/
sudo mv /opt/resolve/libs/libgmodule* /opt/resolve/libs/unneeded/

echo "--- Finished installing ${app_name}"
