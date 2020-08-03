#!/bin/sh

sudo $HOME/UML/linux-4.18.0-147.8.1.el8_1/linux   root=/dev/root   rootfstype=hostfs   rootflags=$HOME/UML/FS   rw   mem=256M   eth0=slirp,,$HOME/UML/slirp   init=init.sh
