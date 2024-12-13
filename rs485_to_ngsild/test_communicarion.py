#!/usr/bin/python
# -*- coding:utf-8 -*-
import serial
import os
import sys
import logging

logging.basicConfig(level=logging.INFO)
libdir = os.path.join(os.path.dirname(os.path.realpath(__file__)), 'lib')
print(libdir)
print(os.path.dirname(os.path.realpath(__file__)))
if os.path.exists(libdir):
    sys.path.append(libdir)
    
import RPi.GPIO as GPIO
import time
from waveshare_RS485_RS232_HAT import config

RS485EN = 22

ser = config.config(Baudrate = 9600 , dev = "/dev/ttySC0")
data = ''
# GPIO.output(RS485EN, GPIO.LOW) 
# time.sleep(0.5)#Waiting to send
# ser.Uart_SendString('Waveshare RS485 RS232 HAT\r\n')
# time.sleep(0.5)#Waiting to send
# GPIO.output(RS485EN, GPIO.HIGH)

try:
    while(1):
        data_t = ser.Uart_ReceiveByte()
        data += str(data_t)
        # print(data)
        if(data_t == '\n'):
            GPIO.output(RS485EN, GPIO.LOW)   
            print(data)
            # time.sleep(0.005)#Waiting to send
            # ser.Uart_SendString(data)
            # time.sleep(0.005)#Waiting to send
            data = ''
            GPIO.output(RS485EN, GPIO.HIGH)
            
except KeyboardInterrupt:    
    logging.info("ctrl + c:")
    exit()


     
     
     
     