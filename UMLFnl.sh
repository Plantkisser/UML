#!/bin/sh
mkdir ~/UML
cp init.sh ~/UML/
cp .config ~/UML/
mkdir ~/tmpker
cd ~/tmpker
wget http://vault.centos.org/8.1.1911/BaseOS/Source/SPackages/kernel-4.18.0-147.8.1.el8_1.src.rpm
rpm2cpio kernel-4.18.0-147.8.1.el8_1.src.rpm | cpio -id
mv linux-4.18.0-147.8.1.el8_1.tar.xz ~/UML
cd ..
rm -R tmpker
cd ~/UML
tar xf linux-4.18.0-147.8.1.el8_1.tar.xz
sudo dnf group install 'Development tools'
cd ~/UML/linux-4.18.0-147.8.1.el8_1
wget -O tini https://github.com/krallin/tini/releases/download/v0.18.0/tini-static
chmod +x tini
mv ~/UML/.config ~/UML/linux-4.18.0-147.8.1.el8_1
sed -i -e '59d' -e '72d' ~/UML/linux-4.18.0-147.8.1.el8_1/kernel/cpu.c
make ARCH=um -j$(nproc)

git clone https://github.com/sleirsgoevy/heroku-buildpack-uml.git
cd heroku-buildpack-uml
tar xzf uml.tar.gz
mv .uml/slirp ~/UML/
cd ../
sudo rm -R heroku-buildpack-uml
mkdir ~/UML/FS
sudo dnf install podman-docker
docker create --name test centos:8.1.1911
docker cp test:/bin ~/UML/FS/
docker cp test:/dev ~/UML/FS/
docker cp test:/etc ~/UML/FS/
docker cp test:/home ~/UML/FS/
docker cp test:/lib ~/UML/FS/
docker cp test:/lib64 ~/UML/FS/
docker cp test:/lost+found ~/UML/FS/
docker cp test:/media ~/UML/FS/
docker cp test:/mnt ~/UML/FS/
docker cp test:/opt ~/UML/FS/
docker cp test:/proc ~/UML/FS/
docker cp test:/root ~/UML/FS/
docker cp test:/run ~/UML/FS/
docker cp test:/sbin ~/UML/FS/
docker cp test:/srv ~/UML/FS/
docker cp test:/sys ~/UML/FS/
docker cp test:/tmp ~/UML/FS/
docker cp test:/usr ~/UML/FS/
docker cp test:/var ~/UML/FS/
wget https://www.busybox.net/downloads/binaries/1.31.0-defconfig-multiarch-musl/busybox-x86_64
mv busybox-x86_64 ~/UML/FS/bin/
cd ~/UML/FS/bin/
rm -f sh
ln -n busybox-x86_64 sh
ln -n busybox-x86_64 ifconfig
ln -n busybox-x86_64 route
chown -R $USER ~/UML/FS
chmod -R 0775 ~/UML/FS
mv ~/UML/init.sh ~/UML/FS
