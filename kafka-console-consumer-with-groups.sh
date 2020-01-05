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