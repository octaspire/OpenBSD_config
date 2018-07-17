#!/usr/bin/env sh


###########################################################################
# Make sure the user really wants to run this script.
###########################################################################
echo "#############################################################"
echo "# Write 'yes' to really copy octaspire OpenBSD configuration."
echo "# Write something else to quit. This script will OVERWRITE"
echo "# any existing files and WILL COPY SOME FILES USING SUDO. "
echo "# Read the script and make sure it is OK, before running."
echo "#############################################################"
read answer
case "$answer" in
    yes ) echo "Starting to copy";;
    * ) exit;;
esac


###########################################################################
# Install new font. Installed fonts can be listed with command "fc-list".
# Make also sure that the installation of the font succeeded.
###########################################################################
echo "Installing font"
if [ ! -d "$HOME/.fonts" ]; then
    mkdir "$HOME/.fonts"
fi
cp AnonymousPro/Anonymous_Pro.ttf "$HOME/.fonts"
fc-cache # update fonts
fc-list -q "Anonymous Pro"
rc=$?; if [[ $rc != 0 ]]; then echo "Font installation failed"; exit $rc; fi


###########################################################################
# Copy dotfiles into home directory.
###########################################################################
echo "Copying dotfiles into $HOME"
cp .kshrc      "$HOME"
cp .profile    "$HOME"
cp .inputrc    "$HOME"
cp .Xdefaults  "$HOME"
cp .Xresources "$HOME"
cp .xinitrc    "$HOME"


###########################################################################
# Copy wsconsctl.conf, doas.conf and rc.conf.local into /etc using sudo
###########################################################################
echo "Copying wsconsctl.conf, doas.conf and rc.conf.local into /etc using sudo"
sudo cp wsconsctl.conf /etc
sudo cp doas.conf      /etc
sudo cp rc.conf.local  /etc
sudo -k # Invalidate possibly cached credentials

