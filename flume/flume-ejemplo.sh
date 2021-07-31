cat /etc/redhat-release
echo $JAVA_HOME

## flume 1
#Instalamos Flume
wget https://apache.claz.org/flume/1.9.0/apache-flume-1.9.0-bin.tar.gz
sudo tar -zxvf apache-flume-1.9.0-bin.tar
cd apache-flume-1.9.0-bin
export FLUME_HOME=/home/centos/apache-flume-1.9.0-bin


# Instalamos Kakfa
cd kafka
wget https://downloads.apache.org/kafka/2.8.0/kafka_2.13-2.8.0.tgz
tar -xzvf kafka_2.13-2.8.0
export KAFKA_HOME=/home/centos/kafka_2.13-2.8.0

# Nueva terminal .- Iniciamos Zookeeper
cd ${KAFKA_HOME}
./bin/zookeeper-server-start.sh config/zookeeper.properties

## Nueva terminal.-  Iniciamos Kafka
cd ${KAFKA_HOME}
./bin/kafka-server-start.sh config/server.properties


## Configuración de Flume
cd $FLUME_HOME
pwd
sudo vi spool-kafka-flume-conf.properties

agent.sources = spool-source
agent.sources.spool-source.type=spooldir
agent.sources.spool-source.spoolDir=/home/centos/flume-data

agent.channels = memoryChannel
agent.sources.spool-source.channels = memoryChannel
agent.channels.memoryChannel.type = memory
agent.channels.memoryChannel.capacity = 100

# Each sink  must be defined
agent.sinks = kafkaSink
agent.sinks.kafkaSink.type=org.apache.flume.sink.kafka.KafkaSink
agent.sinks.kafkaSink.brokerList=localhost:9092
agent.sinks.kafkaSink.topic=spooled
agent.sinks.kafkaSink.channel = memoryChannel

## En una nueva terminal iniciar Flume
cd ${FLUME_HOME}
sudo ./bin/flume-ng agent \
--conf ${FLUME_HOME}/conf/ \
-f ${FLUME_HOME}/conf/spool-kafka-flume-conf.properties \
-n agent \
-Dflume.root.logger=INFO,console


## Insertar datos
cd /home/centos/
pwd
mkdir flume-data

cd /home/centos
vi flume-data/spool-1
{"id":0,"firstName":"tomcy","lastName":"john","dob":"1985-10-20"}{"id":1,"firstName":"rahul","lastName":"dev","dob":"1989-08-15"}{"id":2,"firstName":"pankaj","lastName":"misra","dob":"1982-08-10"}{"id":3,"firstName":"devi","lastName":"lal","dob":"1990-05-06"}{"id":4,"firstName":"john","lastName":"doe","dob":"1992-06-25"}

vi flume-data/spool-2
{"id":10,"firstName":"tomcy","lastName":"john","dob":"1985-10-20"}{"id":11,"firstName":"rahul","lastName":"dev","dob":"1989-08-15"}{"id":12,"firstName":"pankaj","lastName":"misra","dob":"1982-08-10"}{"id":13,"firstName":"devi","lastName":"lal","dob":"1990-05-06"}{"id":14,"firstName":"john","lastName":"doe","dob":"1992-06-25"}

vi flume-data/spool-3
{"id":20,"firstName":"tomcy","lastName":"john","dob":"1985-10-20"}{"id":21,"firstName":"rahul","lastName":"dev","dob":"1989-08-15"}{"id":22,"firstName":"pankaj","lastName":"misra","dob":"1982-08-10"}{"id":23,"firstName":"devi","lastName":"lal","dob":"1990-05-06"}{"id":24,"firstName":"john","lastName":"doe","dob":"1992-06-25"}

## Para ver los datos insertados
## En una nueva terminal
cat /tmp/kafka-logs/spooled-0/00000000000000000000.log

## En una nueva terminal - termina kafka
cd /usr/local/kafka
sudo ./bin/kafka-console-consumer.sh consumer.properties --topic spooled -bootstrap-server localhost:9092 --from-beginning
