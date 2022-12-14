echo "Installing PLymouth for Artix Linux x86_64..."
echo "!! ONLY FOR SDDM !!"

FILE="/bin/sddm"
if [[ -f $FILE ]];then
    echo "SDDM exists, continuing..."
    sudo pacman -U paru-1.11.1-1.3-x86_64.pkg.tar.zst
    paru -S plymouth-nosystemd
    sudo cp plymouth-quit plymouth-start /etc/init.d
    sudo rm -rf /etc/init.d/sddm
    sudo cp sddm /etc/init.d
    sudo chmod +x /etc/init.d/sddm
    sudo chmod +x /etc/init.d/plymouth-start
    sudo chmod +x /etc/init.d/plymouth-quit
    sudo rc-update add sddm
    sudo rc-update add plymouth-start
    sudo rc-update add plymouth-quit
    echo "Add your gpu driver in drivers and plymouth hook in hooks"
    sudo nano /etc/mkinitcpio.conf
    sudo mkinitcpio -P
    sudo cp artix-logo-new /usr/share/plymouth/themes
    sudo plymouth-set-default-theme artix-logo-new
    sudo mkinitcpio -P
else
    echo "SDDM doesn't exist, exiting... "
    exit
fi
