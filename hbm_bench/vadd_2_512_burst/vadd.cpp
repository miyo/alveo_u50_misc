#include <ap_int.h>

extern "C" {
    void vadd(int count,
              ap_uint<512>* a_0, ap_uint<512>* b_0, ap_uint<512>* c_0
              );
}

void vadd(int count,
          ap_uint<512>* a_0, ap_uint<512>* b_0, ap_uint<512>* c_0
          )
{
#pragma HLS INTERFACE s_axilite port=count bundle=control
//
#pragma HLS INTERFACE m_axi     port=a_0 offset=slave max_read_burst_length=16 bundle=gmem0
#pragma HLS INTERFACE s_axilite port=a_0 bundle=control
#pragma HLS INTERFACE m_axi     port=b_0 offset=slave max_read_burst_length=16 bundle=gmem1
#pragma HLS INTERFACE s_axilite port=b_0 bundle=control
#pragma HLS INTERFACE m_axi     port=c_0 offset=slave max_write_burst_length=16 bundle=gmem2
#pragma HLS INTERFACE s_axilite port=c_0 bundle=control
//
#pragma HLS INTERFACE s_axilite port=return bundle=control

    ap_uint<512> tmp_a_0, tmp_b_0, tmp_c_0;

    int x[16];
    int y[16];
    int z[16];

    int num = count / (512/32);

    for(int i = 0; i < num; i++){
#pragma HLS unroll factor=16
#pragma HLS PIPELINE II=1
        tmp_a_0 = a_0[i];
        tmp_b_0 = b_0[i];
        for(int j = 0; j < 16; j++){
            tmp_c_0(j*32+31, j*32) = tmp_a_0.range(j*32+31,j*32) + tmp_b_0.range(j*32+31,j*32);
        }
        c_0[i] = tmp_c_0;
    }

}
