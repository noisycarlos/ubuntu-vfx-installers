#!/bin/bash

installer_path=$(find . -maxdepth 1 -type f -name 'Blackmagic_Fusion_Studio_Linux_*_installer.run')
version=$(echo ${installer_path} | sed -n 's/.\/Blackmagic_Fusion_Studio_Linux_\([0-9.]*\)_installer.run/\1/p')
echo "--- Installing Fusion v${version}..."

sudo apt install libapr1 libaprutil1 libxcb-cursor0 libxcb-damage0
sudo SKIP_PACKAGE_CHECK=1 ${installer_path} -i -y
echo "Finished installing Fusion"
