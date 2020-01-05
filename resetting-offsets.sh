# Resetting Offsets
# Why? Because you may want to replay messages

# Reminder
KafkaPort=9092

# Use --reset-offsets to replay messages
# This is a dry run and will error out. 
kafka-consumer-groups --bootstrap-server localhost:9092 --group my-first-application --reset-offsets --to-earliest

# Provide the execute option
kafka-consumer-groups --bootstrap-server localhost:9092 --group my-first-application --reset-offsets --to-earliest --execute

# Oops we messed up again. 
# We forgot the topic. Doh!
# Use --all-topics carefully ...
# --to-earliest - reset from beginning
# --shift-by - shift the offset by a number (positive or negatve depending on direction)
kafka-consumer-groups --bootstrap-server localhost:9092 --group my-first-application --reset-offsets --to-earliest --topic first_topic

# --reset-offsets                         Reset offsets of consumer group.       
#                                           Supports one consumer group at the   
#                                           time, and instances should be        
#                                           inactive                             
#                                         Has 2 execution options: --dry-run     
#                                           (the default) to plan which offsets  
#                                           to reset, and --execute to update    
#                                           the offsets. Additionally, the --    
#                                           export option is used to export the  
#                                           results to a CSV format.             
#                                         You must choose one of the following   
#                                           reset specifications: --to-datetime, 
#                                           --by-period, --to-earliest, --to-    
#                                           latest, --shift-by, --from-file, --  
#                                           to-current.                          
#                                         To define the scope use --all-topics   
#                                           or --topic. One scope must be        
#                                           specified unless you use '--from-    
#                                           file'.

# Replay the reset consumer group and watch all the messages replay. Woohoo!
kafka-console-consumer --bootstrap-server localhost:$KafkaPort --topic first_topic --group my-first-application
