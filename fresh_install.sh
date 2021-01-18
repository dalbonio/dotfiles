#bash/bin/!

#Sync xbps repo
sudo xbps-install -Su

#install minimal necessary tools
sudo xbps-install vim git xf86-input-libinput openntpd neofetch htop kitty firefox gcc curl wget make xclip ranger -y

#install i3 and xorg
sudo xbps-install i3-gaps i3status i3blocks betterlockscreen xorg xdg-user-folders xorg-fonts rofi compton font-awesome5 -y

#use openntpd as service
sudo sed -i "s/www.google.com/1.1.1.1/g" /etc/ntpd.conf
sudo ln -s /etc/sv/openntpd /var/service

#create important personal folders
installs_folder=$HOME/.installs
mkdir $HOME/folder
mkdir $installs_folder
mkdir $installs_folder/fonts

#create user local fonts directory
mkdir $HOME/.fonts

#add macOs font
git clone https://github.com/supermarin/YosemiteSanFranciscoFont $installs_folder/fonts
cp YosemiteSanFranciscoFont/*.ttf $HOME/.fonts/
fc-cache -fv
xset fp rehash

#use personal dotfiles to config
config_folder=$HOME/.config
dotfiles_folder=$HOME/.dotfiles
i3_local_folder=$HOME/.config/i3
git clone https://github.com/dalbonio/dotfiles.git $dotfiles_folder
cp $dotfiles_folder/i3/config $i3_local_folder
cp $dotfiles_folder/i3/i3blocks.conf $i3_local_folder
git clone https://github.com/vivien/i3blocks-contrib $config_folder/i3blocks


#configure audio
sudo xbps-install alsa-utils alsa-plugins alsa-lib alsa-firmware alsa-plugins-pulseaudio alsa-plugins-ffmpeg pulseaudio apulse pavucontrol
sudo ln -s /etc/sv/alsa /var/service
sudo sv restart alsa

#install ruby and rails
sudo xbps-install autoconf bison readline-devel libressl-devel zlib-devel pkg-config yarn
ruby_version=2.6.1
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
shell_cmd_file=$HOME/custom_shell_commands.txt
touch $shell_cmd_file
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $shell_cmd_file
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> $shell_cmd_file

source ~/.bashrc
#test rbenv by command "type rbenv"

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv install $ruby_version
rbenv global $ruby_version
echo "gem: --no-document" > ~/.gemrc
gem install bundler
gem install rails
rbenv rehash
#test rails by command "rails -v"
#to install postgres the following commands should be uncommented
#sudo touch /usr/share/xbps.d/ignore-packages.conf
#sudo echo 'ignorepkg=postgresql-libs' >> /usr/share/xbps.d/ignore-packages.conf
#sudo xbps-install postgresql postgresql9.6-libs postgresql9.6-libs-devel postgresql-client postgresql-contrib


#creating a ssh key to email
personal_email=dalbonio2@gmail.com
ssh-keygen -t ed25519 -C "$personal_email"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
#public key stored in ~/.ssh/id_ed25519.pub


#git global config
git config --global user.name "Lucas Dalbonio"
git config --global user.email "$personal_email"

#install sxiv, a simple image viewer
git clone https://github.com/muennich/sxiv.git $installs_folder/sxiv
sudo xbps-install imlib2-devel freetype-devel libXft-devel libexif-devel giflib-devel
cd $installs_folder/sxiv
make
sudo make install
cd $HOME

#put a wallpaper
betterlockscreen -u $dotfiles_folder/wallpapers/pink_arch_wallpaper.png -r 1920x1080
betterlockscreen -w dim
