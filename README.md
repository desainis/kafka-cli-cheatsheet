## Kafka Cheat Sheet
- The basics of getting start with Kafka. 

### Starting Kafka
- See `starting-kafka.sh` for further details.
```shell
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
```

### Kafka Topics
- See `kafka-topics.sh` for further details.
```shell
# Kafka Topics
# Assuming you have installed Kafka using a package manager

# Reminder (Defaults)
ZookeeperPort=2181
KafkaPort=9092

# Every topic needs a partition
# Every topic needs a replication factor
# Replcation factor cannot be greater than the number of brokers

# Assuming there is 1 broker...

# Create a Topic
kafka-topics --zookeeper localhost:2181 --topic first_topic --create --partitions 3 --replication-factor 1

#   Change partitions as you see fit
kafka-topics --zookeeper localhost:2181 --topic second_topic --create --partitions 6 --replication-factor 1

# List a topic
kafka-topics --zookeeper localhost:2181 --topic first_topic --list

# Describe a Topic
kafka-topics --zookeeper localhost:2181 --topic first_topic --describe

#Topic:first_topic       PartitionCount:3        ReplicationFactor:1      Configs:
#        Topic: first_topic      Partition: 0    Leader: 0        Replicas: 0     Isr: 0
#        Topic: first_topic      Partition: 1    Leader: 0        Replicas: 0     Isr: 0
#        Topic: first_topic      Partition: 2    Leader: 0        Replicas: 0     Isr: 0

# PartitionCount = number of partitions in this topic
# ReplicationFactor = Replication factor for topic
# Configs = custom configurations for topics
# Leader = Which partition is the leader? Leaders are special partitions in Kafka.
#       All writes and reads to a topic go through the leader and the leader coordinates updating replicas with new data. 
#       If a leader fails, a replica takes over as the new leader.  

# Delete a topic
kafka-topics --zookeeper localhost:2181 --topic first_topic --delete
```

### Kafka Producers
- See `kafka-console-producer.sh` for further details. 
```shell
# Kafka Producer
# A producer produces messages (get it!? I'll see myself out)

KafkaPort=9092
KafkaPath="/some/path/to/kafka/download" # Change this to your local Kafka path e.g. /Users/<user>/Downloads/kafka_2.12-2.4.0

# Create a producer
# Assuming a topic first_topic is already created. See kafka-topics.sh for further details
kafka-console-producer --broker-list localhost:$KafkaPort --topic first_topic
#> hello world
#> how are you?
#> lmao this is so cool?
#> but where is this going though? 

# Create a producer with an ack
# See https://docs.confluent.io/current/installation/configuration/producer-configs.html for further details on what acks mean.
kafka-console-producer --broker-list localhost:$KafkaPort --topic first_topic --producer-property acks=all
#> some acked message
#> hello world again
#> climate change is real
#> This is fun!

# Create a producer for a non existent topic
kafka-console-producer --broker-list localhost:9092 --topic new_topic

# A new topic was created "new_topic"
# Produces a warning because a leader has not been selected upon creation
# Kafka producer will wait for an "election"

# This is a bad default setup for a new topic. Create topics before producing to them!
#Topic:new_topic PartitionCount:1     ReplicationFactor:1      Configs:
#        Topic: new_topic        Partition: 0  Leader: 0       Replicas: 0  Isr: 0

# Change the defaults in $KafkaPath/config/server.properties num.partitions=<num>
sed -i 's/num.partitions=1/num.partitions=3/g' $KafkaPath/config/server.properties
```

### Kafka Consumer
- See `kafka-console-consumer.sh` for further details.
```shell
# Kafka Consumer
# A consumer is the receiver of messages. A consumer .. get it? I'll stop now. 

KafkaPort=9092

# Start a consumer and read topic "first_topic"
kafka-console-consumer --bootstrap-server localhost:9092 --topic first_topic

# Why is this empty even though I produced a few messages moments ago?
# TLDR Kafka is real time

# Get all the messages from a topic
kafka-console-consumer --bootstrap-server localhost:9092 --topic first_topic --from-beginning
```

#### Demo of a Single Consumer and Producer
![Alt Text](./media/consumer-producer-demo.gif)

### Kafka Consumers in a Group
- See `kafka-console-consumer-with-groups.sh` for further details
```shell
# Kafka Consumers with Groups
# Why is this seperate? It's important

# Reminder
KafkaPort=9092

# Use the --group paramter
kafka-console-consumer --bootstrap-server localhost:$KafkaPort --topic first_topic --group my-first-application

# Stand up multiple consumers in the same group
kafka-console-consumer --bootstrap-server localhost:$KafkaPort --topic first_topic --group my-first-application

# Guess what happens if a consumer dies?
# The load is balanced between remaining consumers. 

# List consumer groups
kafka-consumer-groups --bootstrap-server localhost:9092 --list

# Describe consumer groups
# See which application is consuming this topic
kafka-consumer-groups --bootstrap-server localhost:9092 --describe --group my-first-application

#Consumer group 'my-first-application' has no active members.
#
#GROUP                TOPIC           PARTITION  CURRENT-OFFSET  LOG-END-OFFSET  LAG             CONSUMER-ID     HOST            CLIENT-ID
#my-first-application first_topic     0          12              12              0               -               -               -
#my-first-application first_topic     1          15              15              0               -               -               -
#my-first-application first_topic     2          17              17              0               -               -               -

# CURRENT-OFFSET: how many messages have I read so far?
# LOG-END-OFFSET: How many more messages exist?
# LAG: LOG-END-OFFSET - CURRENT-OFFSET (i.e. how many messages do I still have to read)
```

#### Credits to Stephane. Check out his awesome course on [Udemy](https://www.udemy.com/course/apache-kafka/)
