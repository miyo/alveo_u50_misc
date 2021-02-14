#include <ap_int.h>

extern "C" {
    void vadd(int count,
              ap_uint<512>* a_0, ap_uint<512>* b_0, ap_uint<512>* c_0,
              ap_uint<512>* a_1, ap_uint<512>* b_1, ap_uint<512>* c_1,
              ap_uint<512>* a_2, ap_uint<512>* b_2, ap_uint<512>* c_2,
              ap_uint<512>* a_3, ap_uint<512>* b_3, ap_uint<512>* c_3,
              ap_uint<512>* a_4, ap_uint<512>* b_4, ap_uint<512>* c_4,
              ap_uint<512>* a_5, ap_uint<512>* b_5, ap_uint<512>* c_5,
              ap_uint<512>* a_6, ap_uint<512>* b_6, ap_uint<512>* c_6,
              ap_uint<512>* a_7, ap_uint<512>* b_7, ap_uint<512>* c_7,
              ap_uint<512>* a_8, ap_uint<512>* b_8, ap_uint<512>* c_8);
}

void vadd(int count,
              ap_uint<512>* a_0, ap_uint<512>* b_0, ap_uint<512>* c_0,
              ap_uint<512>* a_1, ap_uint<512>* b_1, ap_uint<512>* c_1,
              ap_uint<512>* a_2, ap_uint<512>* b_2, ap_uint<512>* c_2,
              ap_uint<512>* a_3, ap_uint<512>* b_3, ap_uint<512>* c_3,
              ap_uint<512>* a_4, ap_uint<512>* b_4, ap_uint<512>* c_4,
              ap_uint<512>* a_5, ap_uint<512>* b_5, ap_uint<512>* c_5,
              ap_uint<512>* a_6, ap_uint<512>* b_6, ap_uint<512>* c_6,
              ap_uint<512>* a_7, ap_uint<512>* b_7, ap_uint<512>* c_7,
              ap_uint<512>* a_8, ap_uint<512>* b_8, ap_uint<512>* c_8)
{
#pragma HLS INTERFACE s_axilite port=count bundle=control
//
#pragma HLS INTERFACE m_axi     port=a_0 offset=slave bundle=gmem0
#pragma HLS INTERFACE s_axilite port=a_0 bundle=control
#pragma HLS INTERFACE m_axi     port=b_0 offset=slave bundle=gmem1
#pragma HLS INTERFACE s_axilite port=b_0 bundle=control
#pragma HLS INTERFACE m_axi     port=c_0 offset=slave bundle=gmem2
#pragma HLS INTERFACE s_axilite port=c_0 bundle=control
//
#pragma HLS INTERFACE m_axi     port=a_1 offset=slave bundle=gmem3
#pragma HLS INTERFACE s_axilite port=a_1 bundle=control
#pragma HLS INTERFACE m_axi     port=b_1 offset=slave bundle=gmem4
#pragma HLS INTERFACE s_axilite port=b_1 bundle=control
#pragma HLS INTERFACE m_axi     port=c_1 offset=slave bundle=gmem5
#pragma HLS INTERFACE s_axilite port=c_1 bundle=control
//
#pragma HLS INTERFACE m_axi     port=a_2 offset=slave bundle=gmem6
#pragma HLS INTERFACE s_axilite port=a_2 bundle=control
#pragma HLS INTERFACE m_axi     port=b_2 offset=slave bundle=gmem7
#pragma HLS INTERFACE s_axilite port=b_2 bundle=control
#pragma HLS INTERFACE m_axi     port=c_2 offset=slave bundle=gmem8
#pragma HLS INTERFACE s_axilite port=c_2 bundle=control
//
#pragma HLS INTERFACE m_axi     port=a_3 offset=slave bundle=gmem9
#pragma HLS INTERFACE s_axilite port=a_3 bundle=control
#pragma HLS INTERFACE m_axi     port=b_3 offset=slave bundle=gmem10
#pragma HLS INTERFACE s_axilite port=b_3 bundle=control
#pragma HLS INTERFACE m_axi     port=c_3 offset=slave bundle=gmem11
#pragma HLS INTERFACE s_axilite port=c_3 bundle=control
//
#pragma HLS INTERFACE m_axi     port=a_4 offset=slave bundle=gmem12
#pragma HLS INTERFACE s_axilite port=a_4 bundle=control
#pragma HLS INTERFACE m_axi     port=b_4 offset=slave bundle=gmem13
#pragma HLS INTERFACE s_axilite port=b_4 bundle=control
#pragma HLS INTERFACE m_axi     port=c_4 offset=slave bundle=gmem14
#pragma HLS INTERFACE s_axilite port=c_4 bundle=control
//
#pragma HLS INTERFACE m_axi     port=a_5 offset=slave bundle=gmem15
#pragma HLS INTERFACE s_axilite port=a_5 bundle=control
#pragma HLS INTERFACE m_axi     port=b_5 offset=slave bundle=gmem16
#pragma HLS INTERFACE s_axilite port=b_5 bundle=control
#pragma HLS INTERFACE m_axi     port=c_5 offset=slave bundle=gmem17
#pragma HLS INTERFACE s_axilite port=c_5 bundle=control
//
#pragma HLS INTERFACE m_axi     port=a_6 offset=slave bundle=gmem18
#pragma HLS INTERFACE s_axilite port=a_6 bundle=control
#pragma HLS INTERFACE m_axi     port=b_6 offset=slave bundle=gmem19
#pragma HLS INTERFACE s_axilite port=b_6 bundle=control
#pragma HLS INTERFACE m_axi     port=c_6 offset=slave bundle=gmem20
#pragma HLS INTERFACE s_axilite port=c_6 bundle=control
//
#pragma HLS INTERFACE m_axi     port=a_7 offset=slave bundle=gmem21
#pragma HLS INTERFACE s_axilite port=a_7 bundle=control
#pragma HLS INTERFACE m_axi     port=b_7 offset=slave bundle=gmem22
#pragma HLS INTERFACE s_axilite port=b_7 bundle=control
#pragma HLS INTERFACE m_axi     port=c_7 offset=slave bundle=gmem23
#pragma HLS INTERFACE s_axilite port=c_7 bundle=control
//
#pragma HLS INTERFACE m_axi     port=a_8 offset=slave bundle=gmem24
#pragma HLS INTERFACE s_axilite port=a_8 bundle=control
#pragma HLS INTERFACE m_axi     port=b_8 offset=slave bundle=gmem25
#pragma HLS INTERFACE s_axilite port=b_8 bundle=control
#pragma HLS INTERFACE m_axi     port=c_8 offset=slave bundle=gmem26
#pragma HLS INTERFACE s_axilite port=c_8 bundle=control
//
#pragma HLS INTERFACE s_axilite port=return bundle=control

#pragma HLS DATAFLOW

#if 0
    for(int i = 0; i < count; i++){
#pragma HLS PIPELINE
        c_0[i] = a_0[i] + b_0[i];
        c_1[i] = a_1[i] + b_1[i];
        c_2[i] = a_2[i] + b_2[i];
        c_3[i] = a_3[i] + b_3[i];
        c_4[i] = a_4[i] + b_4[i];
        c_5[i] = a_5[i] + b_5[i];
        c_6[i] = a_6[i] + b_6[i];
        c_7[i] = a_7[i] + b_7[i];
        c_8[i] = a_8[i] + b_8[i];
    }
#endif

    const int num = count / 16;

    ap_uint<512> tmp_a_0, tmp_b_0, tmp_c_0;
    for(int i = 0; i < num; i++){
#pragma HLS PIPELINE II=1
        tmp_a_0 = a_0[i];
        tmp_b_0 = b_0[i];
        for(int j = 0; j < 16; j++){
            tmp_c_0(j*32+31, j*32) = tmp_a_0.range(j*32+31,j*32) + tmp_b_0.range(j*32+31,j*32);
        }
        c_0[i] = tmp_c_0;
    }

    ap_uint<512> tmp_a_1, tmp_b_1, tmp_c_1;
    for(int i = 0; i < num; i++){
#pragma HLS PIPELINE II=1
        tmp_a_1 = a_1[i];
        tmp_b_1 = b_1[i];
        for(int j = 0; j < 16; j++){
            tmp_c_1(j*32+31, j*32) = tmp_a_1.range(j*32+31,j*32) + tmp_b_1.range(j*32+31,j*32);
        }
        c_1[i] = tmp_c_1;
    }

    ap_uint<512> tmp_a_2, tmp_b_2, tmp_c_2;
    for(int i = 0; i < num; i++){
#pragma HLS PIPELINE II=1
        tmp_a_2 = a_2[i];
        tmp_b_2 = b_2[i];
        for(int j = 0; j < 16; j++){
            tmp_c_2(j*32+31, j*32) = tmp_a_2.range(j*32+31,j*32) + tmp_b_2.range(j*32+31,j*32);
        }
        c_2[i] = tmp_c_2;
    }

    ap_uint<512> tmp_a_3, tmp_b_3, tmp_c_3;
    for(int i = 0; i < num; i++){
#pragma HLS PIPELINE II=1
        tmp_a_3 = a_3[i];
        tmp_b_3 = b_3[i];
        for(int j = 0; j < 16; j++){
            tmp_c_3(j*32+31, j*32) = tmp_a_3.range(j*32+31,j*32) + tmp_b_3.range(j*32+31,j*32);
        }
        c_3[i] = tmp_c_3;
    }

    ap_uint<512> tmp_a_4, tmp_b_4, tmp_c_4;
    for(int i = 0; i < num; i++){
#pragma HLS PIPELINE II=1
        tmp_a_4 = a_4[i];
        tmp_b_4 = b_4[i];
        for(int j = 0; j < 16; j++){
            tmp_c_4(j*32+31, j*32) = tmp_a_4.range(j*32+31,j*32) + tmp_b_4.range(j*32+31,j*32);
        }
        c_4[i] = tmp_c_4;
    }

    ap_uint<512> tmp_a_5, tmp_b_5, tmp_c_5;
    for(int i = 0; i < num; i++){
#pragma HLS PIPELINE II=1
        tmp_a_5 = a_5[i];
        tmp_b_5 = b_5[i];
        for(int j = 0; j < 16; j++){
            tmp_c_5(j*32+31, j*32) = tmp_a_5.range(j*32+31,j*32) + tmp_b_5.range(j*32+31,j*32);
        }
        c_5[i] = tmp_c_5;
    }

    ap_uint<512> tmp_a_6, tmp_b_6, tmp_c_6;
    for(int i = 0; i < num; i++){
#pragma HLS PIPELINE II=1
        tmp_a_6 = a_6[i];
        tmp_b_6 = b_6[i];
        for(int j = 0; j < 16; j++){
            tmp_c_6(j*32+31, j*32) = tmp_a_6.range(j*32+31,j*32) + tmp_b_6.range(j*32+31,j*32);
        }
        c_6[i] = tmp_c_6;
    }

    ap_uint<512> tmp_a_7, tmp_b_7, tmp_c_7;
    for(int i = 0; i < num; i++){
#pragma HLS PIPELINE II=1
        tmp_a_7 = a_7[i];
        tmp_b_7 = b_7[i];
        for(int j = 0; j < 16; j++){
            tmp_c_7(j*32+31, j*32) = tmp_a_7.range(j*32+31,j*32) + tmp_b_7.range(j*32+31,j*32);
        }
        c_7[i] = tmp_c_7;
    }

    ap_uint<512> tmp_a_8, tmp_b_8, tmp_c_8;
    for(int i = 0; i < num; i++){
#pragma HLS PIPELINE II=1
        tmp_a_8 = a_8[i];
        tmp_b_8 = b_8[i];
        for(int j = 0; j < 16; j++){
            tmp_c_8(j*32+31, j*32) = tmp_a_8.range(j*32+31,j*32) + tmp_b_8.range(j*32+31,j*32);
        }
        c_8[i] = tmp_c_8;
    }

}
