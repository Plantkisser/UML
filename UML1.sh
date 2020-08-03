#!/bin/sh
cd ~
mkdir UML
mkdir tmpker
cd tmpker
wget http://vault.centos.org/8.1.1911/BaseOS/Source/SPackages/kernel-4.18.0-147.8.1.el8_1.src.rpm
rpm2cpio kernel-4.18.0-147.8.1.el8_1.src.rpm | cpio -id
mv linux-4.18.0-147.8.1.el8_1.tar.xz ../UML
cd ..
rm -R tmpker
cd UML
tar xf linux-4.18.0-147.8.1.el8_1.tar.xz
sudo dnf group install 'Development tools'
cd linux-4.18.0-147.8.1.el8_1
wget -O tini https://github.com/krallin/tini/releases/download/v0.18.0/tini-static
chmod +x tini
make ARCH=um oldconfig
