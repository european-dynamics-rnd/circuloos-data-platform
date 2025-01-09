import can

bus1 = can.interface.Bus(interface='socketcan', channel='vcan0', bitrate=500000)
# bus2 = can.interface.Bus('test', bustype='virtual')

mcp9600_temp_float=122.32
pt100_temp_float=3333.32


mcp9600_temp = int(round(mcp9600_temp_float * 100))
pt100_temp = int(round(pt100_temp_float * 100))

data = [0] * 8  # Initialize a list with 4 elements, all set to 0

data[0] = (mcp9600_temp >> 8) & 0xFF  # High byte of mcp9600_temp
data[1] = mcp9600_temp & 0xFF         # Low byte of mcp9600_temp
data[2] = (pt100_temp >> 8) & 0xFF  # High byte of pt100_temp
data[3] = pt100_temp & 0xFF         # Low byte of pt100_temp
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
