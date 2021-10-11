#!/bin/bash

from  PyP100 import PyP100
import configparser
import sys
import serial
import time

config = configparser.ConfigParser()
config.read('.config')
ip      =config['BASE']['ip'] 
email   =config['BASE']['email'] 
password=config['BASE']['password'] 

 #Creating a P100 plug object
p100 = PyP100.P100(ip, email, password)
p100.handshake()
p100.login()

ser = serial.Serial("/dev/tty.usbserial-141140", 115200) 

while True :
    line = ser.readline()
    line = line.decode()
    if 'Writing' in line:
#    if 'USB' in line:
        print ("AAA" + line)
        break
    print(line)    

p100.turnOff() 
time.sleep(3)
p100.turnOn() 
ser.close()
