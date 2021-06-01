#!bin/bash
sudo reflector --verbose -c Brazil --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syy
