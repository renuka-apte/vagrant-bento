#!/usr/bin/env bash

sudo service zookeeper-server init
sudo zookeeper-server start

sudo service hadoop-hdfs-namenode start
sudo service hadoop-hdfs-datanode start

sudo service hbase-master start
sudo service hbase-regionserver start

sudo service hadoop-yarn-resourcemanager start
sudo service hadoop-yarn-nodemanager start

sudo su hdfs /vagrant/hdfs_init.sh

sudo service hadoop-mapreduce-historyserver start

