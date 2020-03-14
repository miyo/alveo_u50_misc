# Use 100GbE of Alveo U50

## build

```
vivado -mode batch -source ./create_project.tcl
```

## try to use

Login to a computer, which connects Alveo U50 with 100GbE, and then, wait for a packet from Alveo U50.

```
cd software/raw_socket
python raw_socket_recv.py
```

After that, assert kick-signal of Alveo U50 to send a packet. 

```
vivado -mode batch -source ./program.tcl
cd software
vivado -mode batch -source ./send_packet.tcl
```
