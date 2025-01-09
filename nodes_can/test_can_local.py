import can

bus1 = can.interface.Bus('test', interface='virtual')
bus2 = can.interface.Bus('test', interface='virtual')

msg1 = can.Message(arbitration_id=0xED1, data=[1,2,3])  # HEX: ED1 DEC: 3793
bus1.send(msg1)
msg2 = bus2.recv()

print(f"msg1:{msg1}")

print(f"msg2:{msg2}")
print(f"msg2.arbitration_id :{msg2.arbitration_id }")

assert msg1.arbitration_id == msg2.arbitration_id
assert msg1.data == msg2.data
assert msg1.timestamp != msg2.timestamp

# assert msg1 == msg2


bus1.shutdown()
bus2.shutdown()