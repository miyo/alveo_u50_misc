import sys
import socket

if __name__ == '__main__':
    ETH_P_ALL = 3
    dev = sys.argv[1]
    message = "Hello Alveo U50"
    data_num = int(sys.argv[2])//len(message) if len(sys.argv) > 2 else 1
    
    mac_addr_str = netifaces.ifaddresses(dev)[netifaces.AF_LINK][0]['addr']
    dest_addr  = b'\x00\x01\x02\x03\x04\x05' # destination address
    #src_addr   = b'\x98\x03\x9b\x1d\x63\x89' # source address
    src_addr   = bytearray([int(x, 16) for x in mac_addr_str.split(':')])
    frame_type = b'\x34\x34' # frame type
    data = (message*data_num).encode() # payload
    
    s = socket.socket(socket.AF_PACKET, socket.SOCK_RAW, socket.htons(ETH_P_ALL))
    s.bind((dev, 0))
    s.sendall(dest_addr + src_addr + frame_type + data)
    s.close()
