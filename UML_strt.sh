#!/bin/sh

cd ~/UML/linux-4.18.0-147.8.1.el8_1
sudo ./linux   root=/dev/root   rootfstype=hostfs   rootflags=$HOME/UML/FS   rw   mem=256M   eth0=slirp,,$HOME/UML/slirp   init=init.sh

