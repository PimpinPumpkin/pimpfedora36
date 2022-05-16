#!/bin/bash
#First written on May 15th, 2022. Currently using Fedora Workstation 36.

#Computer name is Reaper
#Power mode set to performance
#Default applications
#extensions


#enable RPM Fusion
echo Enabling RPM Fusion
sudo dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
  
sudo dnf install \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
 
echo RPM Fusion enabled 
echo Installing dependencies

#Install dependencies for shit I know I need

sudo dnf install ninja-build
sudo dnf install git
sudo dnf install meson
sudo dnf install sassc
sudo dnf install x264
sudo dnf install ffmpeg
sudo dnf install gstreamer1-libav
sudo dnf install openssl
sudo dnf install gnome-shell-extension-pop-shell xprop

echo Dependencies installed successfully
echo Installing Legacy GTK4 theme

#install adw3-gtk theme
git clone https://github.com/lassekongo83/adw-gtk3.git
cd adw-gtk3
meson build
sudo ninja -C build install
cd ../
rm -rf $PWD/adw-gtk3

#install fonts
git clone https://github.com/PimpinPumpkin/pimpfedora36.git
sudo cp -a Google-sans /usr/share/fonts


#install flatpaks
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.mattjakeman.ExtensionManager
flatpak install -y flathub io.freetubeapp.FreeTube
flatpak install flathub com.spotify.Client
flatpak install flathub com.bitwarden.desktop
flatpak install flathub com.brave.Browser
flatpak install flathub org.signal.Signal
flatpak install flathub org.standardnotes.standardnotes
flatpak install flathub io.bassi.Amberol
flatpak install flathub com.github.rafostar.Clapper
flatpak install -y flathub org.gnome.Cheese


#signal auto-start

echo "[Desktop Entry]
Name=Start Signal in Tray
GenericName=signal-start
Comment=Start Signal in Tray
Exec=/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=signal-desktop --file-forwarding org.signal.Signal @@u %U @@ --start-in-tray
Terminal=false
Type=Application
X-GNOME-Autostart-enabled=true" > ~/.config/autostart/org.signal.Signal.desktop


#move window control to the left

gsettings set org.gnome.desktop.wm.preferences button-layout 'close:appmenu'

#change fonts
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Google Sans 18pt Bold 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Source Code Pro 10'
gsettings set org.gnome.desktop.interface document-font-name 'Google Sans 18pt Bold 11'
gsettings set org.gnome.desktop.interface font-name 'Google Sans 18pt Bold 11'

#set legacy application theme to adw3
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'

#set pop shell gaps to zero 
gsettings set org.gnome.shell.extensions.pop-shell gap-inner uint32 0

#set natural scrolling
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll true
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true

#set dark theme
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

#set legacy gtk theme to dark
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'

#change clock to AM/PM

gsettings set org.gnome.desktop.interface clock-format '12h'

gsettings set org.gtk.Settings.FileChooser clock-format '12h'

gsettings set org.gtk.gtk4.Settings.FileChooser clock-format '12h'


#change the locking settings
gsettings set org.gnome.desktop.session idle-delay 900
gsettings set org.gnome.desktop.screensaver idle-activation-enabled 'true'
gsettings set org.gnome.desktop.screensaver lock-enabled 'true'



##NONE OF THIS WORKS
<<COMMENT

#media keys to F7 (prev), F8 (play/pause), F9 (next)

gsettings set org.gnome.settings-daemon.plugins.media-keys previous ['F7']

gsettings set org.gnome.settings-daemon.plugins.media-keys play ['F8']

gsettings set org.gnome.settings-daemon.plugins.media-keys next ['F9']

#Volume keys to F10, (mute/unmute), F11 (down), F12(up)

gsettings set org.gnome.settings-daemon.plugins.media-keys volume-mute ['F10']

gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down ['F11']

gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up ['F12']

#microphone mute toggle
gsettings set org.gnome.settings-daemon.plugins.media-keys mic-mute ['Pause']



#switch workspaces
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right ['<Control>Page_Up']

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right ['<Control>Page_Down']

gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left ['<Shift><Control>Page_Up']

gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right ['<Shift><Control>Page_Down']


#control q to quit
gsettings set org.gnome.Terminal.Legacy.Keybindings close-window '<Control><Shift>q'

#open terminal with ctrl alt t
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "['<Primary><Alt>t']"

COMMENT

#launch gnome settings

gnome-control-center < /dev/null &
