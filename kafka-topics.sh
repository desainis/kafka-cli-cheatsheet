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