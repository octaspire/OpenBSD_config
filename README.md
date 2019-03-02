# Octaspire's OpenBSD configuration

Dotfiles and other configuration files to be used specifically with OpenBSD.

## Usage

You *MUST* check that the `install.sh` script is OK before running it. It will OVERWRITE files
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
stow mg
stow cwm
cd
tmux
# Press CapsLock + b and then %.
mg
# That's it.
````

Some highlights of the configuration:

* Installs a nice-looking TrueType font for xterm (and other xorg).
* Uses *cwm* from the OpenBSD base as the window manager. Cwm keybindings are changed so that those would not conflict with the ones from GNU Emacs.
* Uses *Korn shell* from the OpenBSD base as the shell.
    * Adds custom Korn shell TAB completion for the UNIX password store (pass) command.
* Uses *mg* from the OpenBSD base as the editor.
* Turns CapsLock into a Ctrl (in both console and xorg).
* Turns AltGr into an Alt/Meta (in both console and xorg).
* Enables *apmd* (Advanced Power Management daemon).
* Modifies terminal prompt.

## License

Apache License 2.0. See the directory `AnonymousPro` for the license of the TTF font.

## Installation and post-installation example with full disc encryption into empty Lenovo ThinkPad T470

**Follow these instructions at your own risk. These instructions are not guaranteed to be correct or represent
any best practices; they work for me. Everything on the hard drive will be erased, so make backups
first and check that you can access data on those backups before starting. Also, entering a wrong device name
can cause wrong drive to be erased, if you have more than one, so check the device names and use different
names if there is a need!**

Required: an empty USB flash drive, RJ45 ethernet cable, internet connection and
Thinkpad T470 or similar computer with empty hard drive.

Download OpenBSD 6.3 or newer for amd64 architecture and write it into the flash drive.

1. Connect USB stick and RJ45 cable and boot the machine.
2. Press F12 when the Lenovo logo is shown to enter the Boot Menu.
3. In the Boot Menu, select your USB stick with the arrow keys and press enter.
   (It might be shown as USB HDD: something XYGB). If the machine
   wont start from the USB, you might have to disable secure boot
   at the BIOS configuration. You can enter the setup by rebooting
   the machine and pressing enter during the startup. Look for
   a secure boot setting, and if it is on, turn it off, save the
   settings and try again.
4. When asked wheter to (I)nstall, (U)pgrade, (A)utoinstall or (S)hell, write `s <enter>` for shell.
5. Give command: `dd if=/dev/urandom of=/dev/rsd0c bs=1m`. Grab a coffee;
   this will take about 24 minutes on a T470 and 49 minutes on an X1 Carbon,
   and even longer if you have a larger hard didk.
   **This command will overwrite everything on the disk with random data**.
6. Use GPT for UEFI booting: `fdisk -iy -g -b 960 sd0`.
7. Give command: `disklabel -E sd0`. Inside disklabel:
   ```
   > a a
   offset: [1024/whatever was suggested]
   size: [500103386] *
   FS type: [4.2BSD] RAID
   > w
   > q
   ```
8. Give command: `bioctl -c C -l sd0a softraid0`. And write a new passphrase twice:
   ```
   New passphrase: write_your_passphrase_here
   Re-type passphrase: write_your_passphrase_here
   ...
   softraid0: CRYPTO volume attached as sd3
   ```
   Take a note of the volume name that is reported to be attached as a CRYPTO volume.
   Here it is *sd3*. Also, make absolutely sure that you remember the passphrase you gave.
   If you ever happen to forget it, you **will not be able to decrypt your data anymore**.
9. Give command: `cd /dev`
10. Give command: `sh MAKEDEV sd3`. Use the device name reported by the system at step 8.
11. Give command: `dd if=zero of=rsd3c bs=1m count=1`. Use a raw device name based on the name
    reported by the system at step 8. **Data will be overwritten**.
12. Write `exit <enter>` to return to the installer.
    Later select sd3 as the installation harddisk (Use the device that is reported
    to be attached as CRYPTO volume at step 8).
13. Write `I <enter>` to start installation.
14. Select keyboard layout by writing `us <enter>`, `sv <enter>` or something else.
15. Write a hostname, for example `T470 <enter>`.
16. Write `em0 <enter>` to configure wired network.
17. Select default of *[dhcp]*.
18. Select default of *[none]* for IPv6.
19. *[done]*
20. Select default DNS domain name of *[my.domain]* or enter something else.
21. Enter root password twice.
22. Write `no <enter>` to disable sshd(8).
23. Select default of *[no]* to question about starting X Window System automatically using xenodm(1).
24. Select default *[no]* to question about changing the dafault console to com0.
25. Setup a user, give username and password twice.
26. Select time zone, detected one should be fine.
27. Write `sd3 <enter>` to tell what is the root disk (use the device reported by installer as the CRYPTO volume at step 8).
28. *w* (for whole disk).
29. Select default *[a]* for (A)uto layout.
30. *[done]* because we don't want to initialize more disks.
31. Select default *[http]* as location of sets.
32. *[none]* for no HTTP proxy.
33. Select default HTTP server suggested by the installer, for example *[ftp.eu.openbsd.org]*.
34. Select default Server directory *[pub/OpenBSD/6.3/amd64]*.
35. Select default *[done]* to select all the sets. Wait few minutes for them to download.
36. *[done]*.
37. Write `H <enter>` for (H)alt.
38. Remove usb stick and press a key to reboot.
39. Give passphrase.
40. Login as root.
41. Optional: update system: `syspatch`.
    If syspatch complaints about invalid URL in `/etc/installurl` run command
    `echo "https://ftp.eu.openbsd.org/pub/OpenBSD" > /etc/installurl`
    (or use another mirror that is closer to you).
42. `pkg_add sudo base64 colorls cppcheck cmake coreutils feh stow the_silver_searcher ggrep git gmake gsed gnupg-2.2.4 groff firefox zathura zathura-ps zathura-pdf-mupdf sdl2 sdl2-image sdl2-mixer sdl2-ttf mu offlineimap`
    Install any additional packages you might need. Above is just an example, if you do not need something, don't install it.
43. Use `visudo` command to give 'wheel' group sudo permissions,
    by uncommenting the wheel-line from the sudoers file, as
    instructed in the comments of the file:
    ```
    visudo
    exit
    ```
    After logging out login as your regular user (that can now use `sudo` to run commands as root).
44. `git clone https://github.com/octaspire/OpenBSD_config.git`
45. `cd OpenBSD_config`
46.  `./install.sh`
47. Write `yes`.
48. Give password of the regular unpriviledged user for sudo access.
49. `cd`
50. `git clone https://github.com/octaspire/dotfiles.git`
51. `cd dotfiles`
52. `stow tmux`
53. `stow mg` and `stow cwm`
54. To configure wlan, add file `/etc/hostname.iwm0`:
    `sudoedit /etc/hostname.iwm0`
55. Write into the file the following three lines:
    ```
    nwid your_wlan_id_here
    wpakey your_wlan_password_here
    dhcp
    ```
    Be sure to replace text *your_wlan_id_here* with the name/SSID of
    your wireless network and the text *your_wlan_password_here* with the
    correct WiFi password.
56. Set correct permissions for the file to make it secure,
    or let OpenBSD to fix the pemissions on next reboot.
57. If you want to shorten the boot delay: `sudoedit /etc/boot.conf`
58. Add line `set timeout 2`, save the file and exit editor. Use longer time, if you want.
    This change is not important, it will only make the boot timeout shorter,
    so that machine starts faster.
59. Reboot machine by writing: `doas /sbin/reboot`

All done and the wireless connection should work also.

To build latest GNU Emacs, download `emacs-26.1.tar.gz`, `emacs-26.1.tar.gz.sig` and `gnu-keyring.gpg`.
Issue commands:

```
gpg2 --import gnu-keyring.gpg
gpg2 --verify emacs-26.1.tar.gz.sig emacs-26.1.tar.gz # check that the signature is good.
tar xfz emacs-26.1.tar.gz
cd emacs-26.1
./configure --with-jpeg=no --with-gif=no --with-tiff=no
gmake -j4
sudo gmake install
```

You can make mounting of external flash drives easier by modifying file `/etc/fstab` and
by adding line similar to the one below (check and use the correct device name):

```
/dev/sd2i /stick msdos rw,noauto
```

To Add a nice OpenBSD themed Desktop wallpaper, run the following commands:

````
curl -O https://www.openbsd.org/art/puffy/ppuf1000X907.gif
feh --bg-scale ppuf1000X907.gif
````

The commands above download a picture and then create a `.fehbg` file.
`.xinitrc` checks if that file exists and if it does, runs it, so the wallpaper
endures reboots.

## System performance improvements

Security features are more important in OpenBSD than
the system performance and thus some programs, for example
web browsers, might feel slow compared to other systems.

System performance can be improved, for example, by using
*soft updates* and *ramdisk on /tmp*.

Soft updates can be enabled by modifying file `/etc/fstab` and using
option `softdep`. For example:

````
... / ffs rw,softdep 1 1
````

Although it might be better to do this only for user partitions (?).

To use fast ramdisk for `/tmp`, the previous `/tmp` line in file
`/etc/fstab` can be replaced with this line (or with something
similar):

````
swap /tmp mfs rw,noexec,nosuid,nodev,noatime,-s=2G 0 0
````

By using other value instead of `2G` the size of the ramdisk
can be changed. Depending of the available RAM, you might
want to use a larger or smaller value.

Before the mountpoint `/tmp` is mounted, the permissions
should be fixed:

````sh
# chmod 1777 /tmp
````

If this is not done, `startx` (for example) might fail and
complaint that it cannot write into `/tmp`. In this case
fixing the permissions of `/tmp` and mounting it again
will fix the problem.
