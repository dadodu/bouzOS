#!/bin/bash


# lium_french_f0.tar.gz
wget -O lium_french_f0.tar.gz http://sourceforge.net/projects/cmusphinx/files/Acoustic%20and%20Language%20Models/French%20F0%20Broadcast%20News%20Acoustic%20Model/lium_french_f0.tar.gz/download
tar -xvzf lium_french_f0.tar.gz
cd lium_french_f0/
sudo mkdir -p `pkg-config --variable=modeldir pocketsphinx`/hmm/fr_FR/french_f0
sudo mv * `pkg-config --variable=modeldir pocketsphinx`/hmm/fr_FR/french_f0
cd .. && rm -r lium_french_f0/

# lium_french_f2.tar.gz
#wget -O lium_french_f2.tar.gz http://sourceforge.net/projects/cmusphinx/files/Acoustic%20and%20Language%20Models/French%20F2%20Telephone%20Acoustic%20Model/lium_french_f2.tar.gz/download
#tar -xvzf lium_french_f2.tar.gz
#cd lium_french_f2/
#sudo mkdir -p `pkg-config --variable=modeldir pocketsphinx`/hmm/fr_FR/french_f2
#sudo mv * `pkg-config --variable=modeldir pocketsphinx`/hmm/fr_FR/french_f2
#cd .. && rm -r lium_french_f0/

# french3g62K.lm.dmp
wget -O french3g62K.lm.dmp http://sourceforge.net/projects/cmusphinx/files/Acoustic%20and%20Language%20Models/French%20Language%20Model/french3g62K.lm.dmp/download
sudo mv french3g62K.lm.dmp `pkg-config --variable=modeldir pocketsphinx`/lm/fr_FR/

# frenchWords62K.dic
wget -O frenchWords62K.dic http://sourceforge.net/projects/cmusphinx/files/Acoustic%20and%20Language%20Models/French%20Language%20Model/frenchWords62K.dic/download
sudo mv frenchWords62K.dic `pkg-config --variable=modeldir pocketsphinx`/lm/fr_FR/


