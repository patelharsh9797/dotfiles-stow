#!/usr/bin/env bash

sudo mkdir /var/log/mysql
sudo chown -R mysql:mysql /var/log/mysql
sudo service mysql restart
