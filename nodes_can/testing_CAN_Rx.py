import can  #pip install python-can[serial]
import time
import os

# https://www.beyondlogic.org/adding-can-controller-area-network-to-the-raspberry-pi/

# print('\n\rCAN Rx test')
# print('Bring up CAN0....')
# os.system("sudo /sbin/ip link set can0 up type can bitrate 500000")
time.sleep(0.1)	

try:
	# bus = can.interface.Bus(channel='can0', bustype='socketcan_native')
    bus=can.interface.Bus( interface='socketcan', channel='vcan0', bitrate=500000 )
except OSError:
	print('Cannot find PiCAN board.')
	exit()
	
print('Ready')

try:
	while True:
		message = bus.recv()	# Wait until a message is received.
		print(message)
		c = '{0:f} {1:x} {2:x} '.format(message.timestamp, message.arbitration_id, message.dlc)
		s=''
		for i in range(message.dlc ):
			s +=  '{0:x} '.format(message.data[i])
			
		print(' {}'.format(c+s))
	
	
except KeyboardInterrupt:
	#Catch keyboard interrupt
	os.system("sudo /sbin/ip link set can0 down")
	print('\n\rKeyboard interrtupt')	