#!/bin/bash


# sphinxbase-0.8.tar.gz
wget -O sphinxbase-0.8.tar.gz http://sourceforge.net/projects/cmusphinx/files/sphinxbase/0.8/sphinxbase-0.8.tar.gz/download
tar -xvzf sphinxbase-0.8.tar.gz
cd sphinxbase-0.8
./configure --prefix=/usr/local
make
sudo make install
cd ..

# pocketsphinx-0.8.tar.gz
wget -O pocketsphinx-0.8.tar.gz http://sourceforge.net/projects/cmusphinx/files/pocketsphinx/0.8/pocketsphinx-0.8.tar.gz/download
tar -xvzf pocketsphinx-0.8.tar.gz
cd pocketsphinx-0.8
./configure --prefix=/usr/local
make
sudo make install
cd ..

# sphinxtrain-1.0.8.tar.gz
wget -O sphinxtrain-1.0.8.tar.gz http://sourceforge.net/projects/cmusphinx/files/sphinxtrain/1.0.8/sphinxtrain-1.0.8.tar.gz/download
tar -xvzf sphinxtrain-1.0.8.tar.gz
cd sphinxtrain-1.0.8
./configure --prefix=/usr/local
make
sudo make install
cd ..
