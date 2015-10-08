#!/bin/bash

wget http://tcts.fpms.ac.be/synthesis/mbrola/bin/raspberri_pi/mbrola.tgz
tar xvfz mbrola.tgz
sudo chmod +x mbrola
sudo mv mbrola /usr/bin
sudo rm mbrola.tgz

wget http://tcts.fpms.ac.be/synthesis/mbrola/dba/fr1/fr1-990204.zip
unzip fr1*.zip
sudo mkdir -p /usr/share/mbrola
sudo mv fr1 /usr/share/mbrola
sudo rm fr1*.zip
