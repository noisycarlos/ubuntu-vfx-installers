#!/bin/bash
# Define variables
DESKTOP_FILE=~/.local/share/applications/nuke-indie.desktop
MIME_XML_FILE=/usr/share/mime/packages/nkind.xml
NUKE_EXEC_PATH="/usr/bin/Nuke/Nuke16.0v3/bin/nuke --indie"
# TODO: Make it work for all versions

MIME_TYPE="application/x-nkind"
# Create the .desktop file for Nuke Indie
echo "Creating .desktop file for Nuke Indie..."
mkdir -p ~/.local/share/applications
cat >"$DESKTOP_FILE" <<EOL
[Desktop Entry]
Version=1.0
Name=Nuke Indie
Exec=$NUKE_EXEC_PATH %F
Icon=nuke
Terminal=false
Type=Application
MimeType=$MIME_TYPE;
EOL
# Create the MIME type XML file
echo "Creating MIME type XML file..."
sudo bash -c "cat > $MIME_XML_FILE" <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
  <mime-type type="$MIME_TYPE">
    <comment>Nuke Kind File</comment>
    <glob pattern="*.nkind"/>
  </mime-type>
</mime-info>
EOL
# Update the MIME database
echo "Updating MIME database..."
sudo update-mime-database /usr/share/mime
# Associate the MIME type with the application
echo "Associating MIME type with Nuke Indie..."
xdg-mime default nuke-indie.desktop $MIME_TYPE
# Verify the association
echo "Verifying the association..."
ASSOCIATED_APP=$(xdg-mime query default $MIME_TYPE)
if [ "$ASSOCIATED_APP" == "nuke-indie.desktop" ]; then
  echo "Successfully associated .nkind files with Nuke Indie."
else
  echo "Failed to associate .nkind files with Nuke Indie."
fi
