#!/bin/bash

sudo apt-get install openssh-server build-essential debhelper \
    erlang-nox erlang-dev \
    python-matplotlib gnuplot \
    libtemplate-perl -y
wget https://github.com/processone/tsung/archive/v1.5.0.tar.gz
tar -xvzf v1.5.0.tar.gz
cd tsung-1.5.0
./configure
make
make deb
cd ..
sudo dpkg -i tsung_1.5.0-1_all.deb




tsung -f lookup.xml start


mkdir lookup_aws_LONG_stepwise_output
cd lookup_aws_LONG_stepwise_output
/usr/lib/tsung/bin/tsung_stats.pl --stats /home/omid55/.tsung/log/20160530-1827/tsung.log

google-chrome graph.html
