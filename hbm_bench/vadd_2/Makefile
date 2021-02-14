
all:
	v++ -c -t hw --config design.cfg -k vadd -o vadd.xo vadd.cpp
	v++ -l -t hw --config design.cfg -o vadd.xclbin vadd.xo
	g++ -I$XILINX_XRT/include -I$XILNX_VIVADO/include -Wall -O0 -g -std=c++11 host.cpp -o host -L$XILINX_XRT/lib -lOpenCL -lpthread -lrt -lstdc++
