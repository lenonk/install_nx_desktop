#!/usr/bin/fish

# TODO: Handle dependencies 
sudo pacman -Sy extra-cmake-modules

function build_and_install
    echo "Building and installing $argv"

    if test -d ./build
        rm -rf build
    end

    mkdir build && cd build

    cmake .. >> /dev/null &&
    make >> /dev/null 2>&1 &&
    sudo make install >> /dev/null 2>&1 ||
    echo "CMake failed! Aborting installation.";  exit
end 

function clone_or_update
    if not test -d ./$argv
        echo "Cloning $argv..."
        git clone --quiet https://github.com/nx-desktop/$argv.git >> /dev/null
    else
        pushd .
        cd $argv
        echo "Updating $argv..."
        git fetch origin >> /dev/null
        git merge --ff-only origin/master >> /dev/null
        popd
    end
end

# Luv Icon Theme ##################################
pushd .
if not test -d ./luv-icon-theme
    echo "Cloning Luv Icon Theme..."
    git clone --quiet https://github.com/Nitrux/luv-icon-theme.git >> /dev/null
    cd luv-icon-theme
else
    cd luv-icon-theme
    echo "Updating Luv Icon Theme..."
    git fetch origin >> /dev/null
    git merge --ff-only origin/master
end

echo "Copying Luv Icon Theme..."
if not test -d ~/.local/share/icons
    mkdir -p ~/.local/share/icons
end
cp -rf Luv ~/.local/share/icons
popd
###################################################



# Look and Feel ###################################
clone_or_update nx-plasma-look-and-feel

pushd .
echo "Copying look and feel..."
cd nx-plasma-look-and-feel
echo -e "\tCopying Plasma themes..."

if not test -d ~/.local/share/plasma/desktoptheme
    mkdir -p ~/.local/share/plasma/desktoptheme
end
cp -rf plasma/* ~/.local/share/plasma/desktoptheme/

echo -e "\tCopying color schemes..."

if not test -d ~/.local/share/color-schemes
    mkdir -p ~/.local/share/color-schemes
end
cp -rf color-scheme/* ~/.local/share/color-schemes/

echo -e "\tCopying Konsole profile..."

if not test -d ~/.local/share/konsole
    mkdir -p ~/.local/share/konsole
end
cp -rf konsole/* ~/.local/share/konsole/

echo -e "\tCopying SDDM themes..."

if not test -d ~/.local/share/sddm/themes
    mkdir -p ~/.local/share/sddm/themes
end
sudo cp -rf sddm/* /usr/share/sddm/themes/

echo -e "\tCopying SDDM themes..."

if not test -d ~/.local/share/wallpapers
    mkdir -p ~/.local/share/wallpapers
end
sudo cp -rf wallpapers/* /usr/share/wallpapers/
popd
###################################################


# Kvantum #########################################
clone_or_update nx-kvantum-theme

pushd .
echo "Copying Kvantum themes..."
cd nx-kvantum-theme/themes

if not test -d ~/.config/Kvantum
    mkdir -p ~/.config/Kvantum
end
cp -rf * ~/.config/Kvantum
popd
###################################################


# GTK Themes ######################################
clone_or_update nx-gtk-themes

pushd .
echo "Copying GTK theme..."
cd nx-gtk-themes/src

if not test -d ~/.themes
    mkdir -p ~/.themes
end
cp -rf nitrux ~/.themes
cp -rf nitrux-dark ~/.themes
popd
###################################################


# NX Window Decoration ############################
clone_or_update nx-window-deco

pushd .
cd nx-window-deco
sed -i 's/#include <QPainter>/#include <QPainter>\n#include <QPainterPath>/g' ./breezebutton.cpp
build_and_install "NX Window Decoration"
popd
###################################################


# NX System Tray Applet ###########################
clone_or_update nx-systemtray-applet

pushd .
cd nx-systemtray-applet
build_and_install "NX System Tray Applet"
popd
###################################################


# NX Simple Menu Applet ###########################
clone_or_update nx-simplemenu-applet

pushd .
cd nx-simplemenu-applet
build_and_install "NX Simple Menu Applet"
popd
###################################################


# NX Notifications Applet #########################
clone_or_update nx-notifications-applet

pushd .
cd nx-notifications-applet
build_and_install "NX Notifications Applet"
popd
###################################################


# NX Network Management Applet ####################
clone_or_update nx-networkmanagement-applet

pushd .
cd nx-networkmanagement-applet
build_and_install "NX Network Management Applet"
popd
###################################################


# NX Firewall #####################################
clone_or_update nx-firewall

pushd .
cd nx-firewall
build_and_install "NX Firewall"
popd
###################################################


# NX Clock Applet #################################
clone_or_update nx-clock-applet

pushd .
cd nx-clock-applet
build_and_install "NX Clock Applet"
popd
###################################################


# NX Audio Applet #################################
clone_or_update nx-audio-applet

pushd .
cd nx-audio-applet
build_and_install "NX Audio Applet"
popd
###################################################

