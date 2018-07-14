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
