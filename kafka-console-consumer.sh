# Kafka Consumer
# A consumer is the receiver of messages. A consumer .. get it? I'll stop now. 

KafkaPort=9092

# Start a consumer and read topic "first_topic"
kafka-console-consumer --bootstrap-server localhost:9092 --topic first_topic

# Why is this empty even though I produced a few messages moments ago?
# TLDR Kafka is real time

# Get all the messages from a topic
kafka-console-consumer --bootstrap-server localhost:9092 --topic first_topic --from-beginning