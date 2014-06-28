                              _  _                   
                             | |(_)                  
      _   _ _   _ _   _ _   _| | _ ____  _   _ _   _ 
     | | | | | | | | | | | | | || |  _ \| | | ( \ / )
     | |_| | |_| | |_| | |_| | || | | | | |_| |) X ( 
      \__  |____/ \__  |____/ \_)_|_| |_|____/(_/ \_)
      (____/      (____/       

     release 0.0: energetic yuzuko
     
### Installation instructions

**WARNING:** Those are both unsupported and the only way to install Yuyulinux right now. A live CD will be released when the distro is more stable.

**WARNING:** x86_64 only for now.

1. Grab the Arch Linux live CD, an Arch Linux installation or pretty much anything with pacman installed **or** compile pacman from source and install it locally.

2. Create a partition to which you will install the system. Make it at least 500MB, though 4GB is recommended for fitting most of what you'd want in the system.

3. Copy over the pacman.conf from https://github.com/asiekierka/yuyulinux/blob/master/pacman/pacman.conf to your system-wide /etc. (Keep a backup if you're on an Arch Linux installation.)

4. Execute the following commands **as root**, where $ROOT is the mountpoint of the partition you created in Step 2:

        # create pacman directory structure
        mkdir -p $ROOT/var/cache/pacman
        mkdir -p $ROOT/var/lib/pacman
        # install base packages and syslinux
        pacman -Sy -r $ROOT/ base
        pacman -S -r $ROOT/ syslinux
        # prepare chroot
        cd $ROOT/
        mount -o bind /dev $ROOT/dev
        mount -o bind /proc $ROOT/proc
        mount -o bind /sys $ROOT/sys
        cp /etc/resolv.conf $ROOT/etc/
        cat /proc/mounts > /etc/mtab
        # go into chroot, create valid /dev structure
        chroot . /bin/mksh
        mdev -s
        exit
        # go into chroot with proper /dev to fix mksh
        chroot . /bin/mksh

5. Make any last-minute changes to your system now.

6. If you already have a bootloader, skip this step and adapt the config in Step 7. Otherwise, install Syslinux to your hard drive with

        pacman -S nano
        nano /etc/fstab # create fstab file here
        mkdir -p /boot/extlinux
        extlinux --install /boot/extlinux

7. If you installed Syslinux, create a /boot/extlinux.conf with the following contents, where sd?? is the partition you installed YuYuLinux to.

        LABEL linux
                KERNEL /boot/vmlinuz-3.14.5
                APPEND root=/dev/sd?? init=/bin/init

8. Reboot, hope it boots and then type "linux" at the boot: prompt (extlinux) or boot the distro in your preferred way (other bootloader).
