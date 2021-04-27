from  PyP100 import PyP100
import configparser
import sys

config = configparser.ConfigParser()
config.read('.config')

ip      =config['BASE']['ip'] 
email   =config['BASE']['email'] 
password=config['BASE']['password'] 

 #Creating a P100 plug object
p100 = PyP100.P100(ip, email, password)
p100.handshake()
p100.login()

if len(sys.argv) < 2:
    device_info = p100.getDeviceInfo() #Returns dict with all the device info
    print (device_info)
elif sys.argv[1] == "on":
    p100.turnOn() 
elif sys.argv[1] == "off":
    p100.turnOff() 
else:
    print ('Specify "on" or "off" for argument.')


