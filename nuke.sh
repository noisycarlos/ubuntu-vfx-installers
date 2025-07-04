#!/bin/bash

app_name="Nuke"

# installer_path=$(find . -maxdepth 1 -type f -name 'Nuke*-linux-x86_64.run')
installer_path=$(find . -maxdepth 1 -type f -name 'Nuke*-linux-x86_64.run' | sort -V | tail -n 1)

if [ ! -f "$installer_path" ]; then
  echo "--- Skipping installation of ${app_name}, no installers found."
  exit 1
fi

version=$(echo ${installer_path} | sed -n 's/.\/Nuke\([0-9.v]*\)-linux-x86_64.run/\1/p')

nuke_install_basepath=/usr/bin/Nuke
installation_dir_name=Nuke${version}
vnum="${version%%v*}"

echo "--- Installing ${app_name} version ${version} - ${installer_path}..."
echo "--- ${vnum} - ${installation_dir_name}"

sudo chmod +x ${installer_path}
sudo ${installer_path} --accept-foundry-eula

echo "--- Moving application to bin directory..."
if [ ! -d "${nuke_install_basepath}" ]; then
  sudo mkdir ${nuke_install_basepath} >/dev/null
fi

sudo rm -r ${nuke_install_basepath}/${installation_dir_name}
sudo mv ./${installation_dir_name} ${nuke_install_basepath}/

sudo cp ./nuke.png ${nuke_install_basepath}/nuke.png

echo "--- Creating Application shortcuts..."
sudo mkdir -p ~/.local/share/applications/
sudo chmod -R 777 ~/.local/share/applications/
cd ~/.local/share/applications/

variations=(
  "Nuke:"
  "Nuke Indie:--indie"
  "Nuke Non-commercial:--nc"
  "NukeX:--nukex"
)

# Loop through each variation
for variation in "${variations[@]}"; do
  IFS=':' read -r name flag <<<"$variation"
  shortcut_filename=$(echo "${name}_${version}" | tr -d ' .')

  echo "#!/usr/bin/env xdg-open
[Desktop Entry]
Version=1.0
Terminal=false
Type=Application
Name=${name} ${version}
Exec=${nuke_install_basepath}/${installation_dir_name}/Nuke${vnum} ${flag}
Icon=${nuke_install_basepath}/nuke.png" >${shortcut_filename}.desktop
done

# echo "--- Cleanup..."
# if [ "${delete_installer}" = 1 ]; then
#   echo "deleting downloaded installer..."
#   rm ${installer_path}
#   sudo rm -r ./Nuke${version} >>/dev/null
# else
#   echo "leaving previously-existing installer in place..."
# fi
echo "--- Finished installing ${app_name}"
