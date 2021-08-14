# primer argumento es la carpeta donde se guardaran los json
# segundo argumento es el número de archvios

import sys
import time
import datetime
import json
import random

n = 100
x = 0
while x < n:
  device_id = x + 1
  timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
  speed = 25+(x*5)*random.random()
  accelerometer_x = 25+((x*-1)*5)*random.random() 
  accelerometer_y = (10*(n%2))+((x*-1)*2)*random.random()
  accelerometer_z = ((x*-1)*5)*random.random()
  archivo = 'spool-' + str(x)
  x += 1
  texto = {'device_id':device_id, 'timestamp':timestamp, 'speed': speed, 
           'accelerometer_x': accelerometer_x, 'accelerometer_y': accelerometer_y,
           'accelerometer_z': accelerometer_z}
  with open('/home/centos/flume-data/'+ archivo, 'w') as f:
    json.dump(texto, f)
  if device_id > 5:
    device_id = 0
  time.sleep(5)