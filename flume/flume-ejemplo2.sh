
## flume 2


sudo vi conf/spool-fileChannel-kafka-flume-conf.properties
#sudo rm conf/spool-fileChannel-kafka-flume-conf.properties

## Configuración de sink hdfs 
agent.sources = spool-source
agent.sources.spool-source.type=spooldir
agent.sources.spool-source.spoolDir=/Users/neftalivaldez/flume-data
agent.sources.spool-source.interceptors=ts uuid

#Timestamp Interceptor Definition
agent.sources.spool-source.interceptors.ts.type=timestamp

#UUID Interceptor Definition
agent.sources.spool-source.interceptors.uuid.type=org.apache.flume.sink.solr.morphline.UUIDInterceptor$Builder
agent.sources.spool-source.interceptors.uuid.headerName=eventId

# The channel can be defined as follows.
agent.channels = fileChannel
agent.channels.fileChannel.type = file
agent.channels.fileChannel.capacity = 100
agent.channels.fileChannel.transactionCapacity=10
agent.channels.fileChannel.dataDirs=/Users/neftalivaldez/flume-data/flume-channel/data
agent.channels.fileChannel.checkpointDir=/Users/neftalivaldez/flume-data/flume-channel/checkpoint
agent.sources.spool-source.channels = fileChannel

# Each sink  must be defined
agent.sinks = kafkaSink
agent.sinks.kafkaSink.type=org.apache.flume.sink.kafka.KafkaSink
agent.sinks.kafkaSink.brokerList=localhost:9092
agent.sinks.kafkaSink.topic=spooled-fileChannel
agent.sinks.kafkaSink.channel = fileChannel
agent.sinks.kafkaSink.useFlumeEventFormat=true

cd flume-data
ls

rm spool-1.COMPLETED 
rm spool-2.COMPLETED 
rm spool-3.COMPLETED 

ls
mkdir data
mkdir checkpoint

# En termina de Flume
echo $JAVA_HOME
sudo ./bin/flume-ng agent --conf ${FLUME_HOME}/conf/  -f ${FLUME_HOME}/conf/spool-fileChannel-kafka-flume-conf.properties  -n agent -Dflume.root.logger=INFO,console

## En terminal de kafka consumer
sudo ./bin/kafka-console-consumer.sh consumer.properties --topic spooled-fileChannel -bootstrap-server localhost:9092 --from-beginning


cat ~/flume-data/flume-channel/data/log-1) file as shown next:
cat /tmp/kafka-logs/spooled-0/00000000000000000000.log




