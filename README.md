# Octaspire's OpenBSD configuration

Dotfiles and other configuration files to be used
specifically with OpenBSD.

## Usage

You *MUST* check that the `install.sh` script
is OK before running it. It will OVERWRITE files
and copy some files using *SUDO*.
 
````sh
cd OpenBSD_config
./install.sh
cd
startx
# Press CapsLock + Alt + enter
# Press CapsLock + Alt + f
git clone https://github.com/octaspire/dotfiles.git
cd dotfiles
stow tmux
cd
tmux
# Press CapsLock + b and then %.
mg
# That's it.
````

Some highlights of the configuration:

* Installs a nice-looking TrueType font for xterm (and other xorg).
* Uses *cwm* from the OpenBSD base as the window manager.
* Uses *Korn shell* from the OpenBSD base as the shell.
* Uses *mg* from the OpenBSD base as the editor.
* Turns CapsLock into a Ctrl (in both console and xorg).
* Turns AltGr into an Alt/Meta (in both console and xorg).
* Sets *us* keyboard layout.
* Enables *apmd* (Advanced Power Management daemon).
* Modifies terminal prompt.

## License

Apache License 2.0. See the directory `AnonymousPro` for the license of
the TTF font.

## About OpenBSD installation and post-installation

When installing OpenBSD and the installer asks wheter to install
*X Window System*, select the default answer *yes*. Select the
default answer of *no* when asked whether *xenomdm* should start
the X Window System. Create also a regular user that belongs into
the 'wheel' group so that you can use 'sudo' later.

To update the system after installation and to install required
packages to be able to use this configuration and also to build
Octaspire Dern, run the following commands as the *root* user:

````sh
syspatch
# If syspatch complaints about invalid URL in /etc/installurl
# run command
# echo "https://ftp.eu.openbsd.org/pub/OpenBSD" > /etc/installurl
# or use another mirror that is closer to you.
pkg_add sudo colorls stow git gmake sdl2 sdl2-image sdl2-mixer sdl2-ttf
# Use 'visudo' command to give 'wheel' group sudo permissions, by
# uncommenting the wheel-line from the sudoers file, as instructed
# in the comments of the file.
visudo
exit
````

Run the following commands as your regular user:

````sh
git clone https://github.com/octaspire/OpenBSD_config.git
cd OpenBSD_config
./install.sh
# Write 'yes'.
# Give password of the regular user for sudo access.
cd
git clone https://github.com/octaspire/dotfiles.git
cd dotfiles
stow tmux
````
