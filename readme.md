# VFX Installers for Ubuntu #

This repository contains scripts to install Nuke, Resolve, and Fusion. These programs are commonly used in Visual Effects and post-production. However they're not particularly easy to install in Linux because they're not distributed as standard Linux installer files (deb, rpm, flatpak, etc).

There are individual scripts for each program, and one to install them all automatically. 

Due to copyright and distribution rights, you have to download the installers yourself.

## Instructions ##

### Step 1 ###
Download or clone this repository wherever you wish, for example your Downloads directory.
### Step 2 ###
Download the Linux installers for the apps you wish to install from their respective websites. You don't need to download all the installers, just the ones you need.
- [Nuke](https://www.foundry.com/products/nuke/download)
- [Resolve](https://www.blackmagicdesign.com/products/davinciresolve)
- [Fusion](https://www.blackmagicdesign.com/products/fusion)
### Step 3 ###
Unzip the downloaded files and place the installers that you want inside the repository directory, next to the scripts.

 #### Things to check: ####
- All the installers should have a .run extension
- Make sure you don't change the file names from the compressed file. Just uncompress it to the directory. 
- The Fusion package contains two .run files. Make sure you use the one that says 'Studio', not the one that says 'Render Node'. For example:  ```Blackmagic_Fusion_Studio_Linux_19.1.4_installer.run```

### Step 4 ###
If you wish to install all the programs at once, run the install-all.sh script (it will only install the apps for which you placed an installer). Otherwise, use the individual script for each application.

To run the script, there are a few ways. Probably the easiest is to right-click on the directory with the scripts and installers, then select 'Open in Terminal'.

Once you're in the terminal, type bash followed by the name of the script you want to . For example:

```bash install-all.sh```

# IMPORTANT #
If you get the following error:

```AppImages require FUSE to run. ```

You need to install FUSE with the following command:

``` sudo apt install libfuse2 -y ```


The reason this is not done automatically in the script is because on one occasion installing FUSE misconfigured my desktop environment. I didn't want someone to run the script, get their system bonked and not know what happened.

My system was fixed with the commands below, but just in case do a backup before you install FUSE:

```
sudo apt purge gdm3
sudo apt install gdm3
```

(solution from [askubuntu.com](https://askubuntu.com/questions/1525899/cannot-login-to-gui-on-ubuntu-24-04-after-installing-fuse) )
