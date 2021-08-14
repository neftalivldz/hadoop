cat /etc/redhat-release
echo $JAVA_HOME

## flume 1
#Instalamos Flume
wget https://apache.claz.org/flume/1.9.0/apache-flume-1.9.0-bin.tar.gz
tar -zxvf apache-flume-1.9.0-bin.tar
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
vi conf/spool-kafka-flume-conf.properties

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
./bin/flume-ng agent \
--conf ${FLUME_HOME}/conf/ \
-f ${FLUME_HOME}/conf/spool-kafka-flume-conf.properties \
-n agent \
-Dflume.root.logger=INFO,console

## Instalación de spark
cd /home/centos
wget https://archive.apache.org/dist/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz
tar -xvf spark-3.1.2-bin-hadoop3.2.tgz

## Instalación de python3
sudo yum install python3$ which python3
which pip3
# Instalación de pandas
sudo pip3 install pandas
# Instalación de kafka python
sudo pip3 install kafka-python
# Se exporta la macrovariable PYSPARK_PYTHON para trabajar con python3
export PYSPARK_PYTHON=python3


