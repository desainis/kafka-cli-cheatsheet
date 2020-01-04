# Assuming you've already downloaded and installed Kafka
# If not, see the quick start guide for downloading Kafka https://kafka.apache.org/quickstart
# Install using brew or any package manager makes life much easier!

KafkaPath="/some/path/to/kafka/download" # Change this to your local Kafka path e.g. /Users/<user>/Downloads/kafka_2.12-2.4.0

# Ports 
ZooKeeperPort=2181
KafkaPort=9092

# Create a folder to store some data from zookeeper and kafka
# Change this accordingly...
mkdir $KafkaPath/data
mkdir $KafkaPath/data/zookeeper
mkdir $KafkaPath/data/kafka

# You may want to change the data directory in zookeeper.properties
# In this case we're replacing /tmp/zookeeper with data/zookeeper
sed -i 's/tmp//zookeeper/data//zookeeper/g' $KafkaPath/config/zookeeper.properties

# You may want to change the logs directory for Kafka
# In this case we're replacing /tmp/kafka with data/kafka in KafkaPath
sed -i 's/tmp//kafka/data//kafka/g' $KafkaPath/config/server.properties

# Zookeeper Start (This is assuming you installed kafka from a package manager)
zookeeper-server-start $KafkaPath/config/zookeeper.properties
kafka-server-start $KafkaPath/config/server.properties