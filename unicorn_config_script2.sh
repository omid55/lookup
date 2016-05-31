#!/bin/bash
sudo chmod 755 /etc/init.d/unicorn_lookup
sudo update-rc.d unicorn_lookup defaults

sudo service unicorn_lookup start
