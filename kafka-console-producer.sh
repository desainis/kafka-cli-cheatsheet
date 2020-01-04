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