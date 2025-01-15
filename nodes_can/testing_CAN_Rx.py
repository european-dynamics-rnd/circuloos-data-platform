import can  #pip install F[serial]
import time
import os

# https://www.beyondlogic.org/adding-can-controller-area-network-to-the-raspberry-pi/

simulating=False

print('\n\rCAN Rx test')
if not simulating:
	print('Bring up CAN0....')
	os.system("sudo /sbin/ip link set can0 up type can bitrate 500000")

time.sleep(0.1)	

try:
	if simulating:
		bus=can.interface.Bus( interface='socketcan', channel='vcan0', bitrate=500000 )
	else:
		bus = can.interface.Bus(channel='can0', bustype='socketcan')
except OSError:
	print('Cannot find hardware board found.')
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
		print(f"message.arbitration_id:{message.arbitration_id}")
		if message.arbitration_id == 1745:   # from sim  3793,  arduiono: 1745
			print(f"Message from sensor !!!")
			temp1 = (message.data[0] << 8) | message.data[1]
			# Combine high and low bytes for temp2
			temp2 = (message.data[2] << 8) | message.data[3]
			print(f"temp1: {temp1/100}")
			print(f"temp2: {temp2/10}")

	
	
except KeyboardInterrupt:
	#Catch keyboard interrupt
	os.system("sudo /sbin/ip link set can0 down")
	print('\n\rKeyboard interrtupt')	
