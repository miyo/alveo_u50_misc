import sys
import time
import socket
import binascii
import netifaces

if __name__ == '__main__':
    ETH_P_ALL = 3

    if len(sys.argv) < 2:
        print("python raw_socket_sendrecv.py ehternet [bytes] [repeat]")
        sys.exit(0)

    dev = sys.argv[1]
    if not dev in netifaces.interfaces():
        print("unknown network interface:", dev)
        sys.exit(0)
        
    message = "Hello Alveo U50"*9000
    data_bytes = int(sys.argv[2]) if len(sys.argv) > 2 else 64
    data_bytes = 64 if data_bytes < 64 else data_bytes
    print("payload bytes =", data_bytes, ", total bytes =", (data_bytes+14))
    
    repeat = int(sys.argv[3]) if len(sys.argv) > 3 else 1
    repeat = 1 if repeat < 1 else repeat
    if repeat > 1:
        print("repeat times =", repeat)

    mac_addr_str = netifaces.ifaddresses(dev)[netifaces.AF_LINK][0]['addr']
    dest_addr  = b'\x00\x01\x02\x03\x04\x05' # destination address
    #src_addr   = b'\x98\x03\x9b\x1d\x63\x89' # source address
    src_addr   = bytearray([int(x, 16) for x in mac_addr_str.split(':')])
    frame_type = b'\x34\x34' # frame type
    data = message[0:data_bytes].encode() # payload
    
    s = socket.socket(socket.AF_PACKET, socket.SOCK_RAW, socket.htons(ETH_P_ALL))
    s.bind((dev, 0))

    start = time.time()
    rdata = None
    for i in range(repeat):
        s.sendall(dest_addr + src_addr + frame_type + data)
        rdata = s.recv(data_bytes+14)
    end = time.time()
    print("elapsed time:", (end-start), "sec.")
    print("RTT:", (end-start)/repeat, "sec.", "bytes:", data_bytes)
        
    if repeat == 1:
        print("recv")
        print(binascii.hexlify(rdata[:6]))
        print(binascii.hexlify(rdata[6:6+6]))
        print(binascii.hexlify(rdata[6+6:6+6+2]))
        print(rdata[6+6+2:])
        
    s.close()
