import can

bus1 = can.interface.Bus(interface='socketcan', channel='vcan0', bitrate=500000)
# bus2 = can.interface.Bus('test', bustype='virtual')

temp1 = 0x1234  # Example value (replace with your actual value)
temp2 = 0x5678  # Example value (replace with your actual value)

data = [0] * 8  # Initialize a list with 4 elements, all set to 0

data[0] = (temp1 >> 8) & 0xFF  # High byte of temp1
data[1] = temp1 & 0xFF         # Low byte of temp1
data[2] = (temp2 >> 8) & 0xFF  # High byte of temp2
data[3] = temp2 & 0xFF         # Low byte of temp2
data[3] = 0xAA  # 0xAA is 0b10101010
data[4] = 0xAA
data[5] = 0xAA
data[6] = 0xAA
data[7] = 0xAA


msg1 = can.Message(arbitration_id=0xED1, data=data)  # HEX: ED1 DEC: 3793
bus1.send(msg1)


# msg2 = bus2.recv()

# print(f"msg1:{msg1}")

# print(f"msg2:{msg2}")
# print(f"msg2.arbitration_id :{msg2.arbitration_id }")

bus1.shutdown()
