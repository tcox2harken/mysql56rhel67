#!/usr/bin/env bash

echo "RUN AS SUDO"

set -e

if [ -e "/tmp/.mysql_repo_installed" ]
then
    echo "mysql repo already installed - skipping"
else
    wget http://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm
    yum -y localinstall mysql57-community-release-el6-7.noarch.rpm
    cp mysql-community.repo /etc/yum.repos.d/mysql-community.repo
    touch /tmp/.mysql_repo_installed
    echo "finished installing mysql repo"
fi

if [ -e "/tmp/.mysql_packages_installed" ]
then
    echo "mysql_packages_installed"
else
    yum -y install mysql-community-server mysql-devel
    touch /tmp/.mysql_packages_installed
    echo "finished installing mysql packages"
fi

chkconfig mysqld on
service mysqld start

echo "mysql install COMPLETE"

popd