import sys
import socket

if __name__ == '__main__':
    ETH_P_ALL = 3
    dev = sys.argv[1]
    s = socket.socket(socket.AF_PACKET, socket.SOCK_RAW, socket.htons(ETH_P_ALL))
    s.bind((dev, 0))
    data = s.recv(9000)
    print(data)
    s.close()
