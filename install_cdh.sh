#!/usr/bin/env bash

if [ ! -f /etc/apt/sources.list.d/cloudera.list ]
then
  sudo touch /etc/apt/sources.list.d/cloudera.list
fi
sudo bash -c 'cat > /etc/apt/sources.list.d/cloudera.list << EOL
deb [arch=amd64] http://archive.cloudera.com/cdh5/ubuntu/precise/amd64/cdh precise-cdh5 contrib
deb-src http://archive.cloudera.com/cdh5/ubuntu/precise/amd64/cdh precise-cdh5 contrib
EOL'

curl -s http://archive.cloudera.com/cdh5/ubuntu/precise/amd64/cdh/archive.key | sudo apt-key add -

sudo bash -c 'cat > /etc/apt/preferences << EOL
Package: *
Pin: release n=trusty
Pin-Priority: 100

Package: *
Pin: release n=precise-cdh5
Pin-Priority: 600
EOL'

sudo apt-get update

sudo dpkg -i /tmp/zookeeper.deb

sudo apt-get -y install \
  zookeeper-server \
  hadoop-hdfs-namenode \
  hadoop-hdfs-datanode \
  hadoop-yarn-resourcemanager \
  hadoop-yarn-nodemanager \
  hadoop-yarn-proxyserver \
  hadoop-mapreduce \
  hadoop-mapreduce-historyserver \
  hbase-master \
  hbase-regionserver

sudo update-alternatives --verbose --install /etc/hadoop/conf hadoop-conf /vagrant/hadoop-conf 50
sudo update-alternatives --set hadoop-conf /vagrant/hadoop-conf

sudo update-alternatives --verbose --install /etc/zookeeper/conf zookeeper-conf /vagrant/zookeeper-conf 50
sudo update-alternatives --set zookeeper-conf /vagrant/zookeeper-conf

sudo update-alternatives --verbose --install /etc/hbase/conf hbase-conf /vagrant/hbase-conf 50
sudo update-alternatives --set hbase-conf /vagrant/hbase-conf

sudo su hdfs << EOF
hdfs namenode -format
mkdir -p /var/log/hadoop-hdfs
EOF

sudo su zookeeper << EOF
zookeeper-server-initialize
mkdir -p /var/log/zookeeper
EOF

sudo su hbase << EOF
mkdir -p /var/log/hbase
EOF

sudo su yarn << EOF
mkdir -p /var/log/hadoop-yarn
EOF

sudo su mapred << EOF
mkdir -p /var/log/hadoop-mapreduce
EOF

