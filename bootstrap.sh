#!/usr/bin/env bash

#this is install bootstrap for ubuntu 14.04

# we need odoo user
sudo adduser --system --home=/opt/odoo --group odoo

# updating repos
apt-get update

#installing postgresql
apt-get install -y postgresql
#creating user for postgres
sudo su - postgres -c "createuser --createdb --username postgres --no-createrole --no-superuser --no-password odoo"

#installing needed packages
sudo apt-get install -y python-dateutil python-decorator python-docutils python-feedparser \
python-gdata python-gevent python-imaging python-jinja2 python-ldap python-libxslt1 python-lxml \
python-mako python-mock python-openid python-passlib python-psutil python-psycopg2 python-pybabel \
python-pychart python-pydot python-pyparsing python-pypdf python-reportlab python-requests \
python-simplejson python-tz python-unittest2 python-vatnumber python-vobject python-werkzeug \
python-xlwt python-yaml wkhtmltopdf

#we need git
sudo apt-get install -y git

#cloning openerp code
sudo su - odoo -s /bin/bash -c "git clone https://www.github.com/odoo/odoo --depth 1 --branch 8.0 --single-branch ."

#preparing configuration
sudo cp /vagrant/openerp-server.conf /etc/odoo-server.conf
sudo chown odoo: /etc/odoo-server.conf
sudo chmod 640 /etc/odoo-server.conf

#preparing init script
cp /vagrant/odoo-server-init /etc/init.d/odoo-server
sudo chmod 755 /etc/init.d/odoo-server
sudo chown root: /etc/init.d/odoo-server
sudo update-rc.d odoo-server defaults

#preparing log directory
sudo mkdir /var/log/odoo
sudo chown odoo:root /var/log/odoo

#thats all folks , just do vagrant reload

