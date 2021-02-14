/**********
Copyright (c) 2018, Xilinx, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors
may be used to endorse or promote products derived from this software
without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**********/

#include "host.hpp"

int main(int argc, char** argv)
{
    if (argc != 2) {
        std::cout << "Usage: " << argv[0] << " <XCLBIN File>" << std::endl;
		return EXIT_FAILURE;
	}

    std::string binaryFile = argv[1];
    size_t vector_size_bytes = sizeof(int) * DATA_SIZE;
    cl_int err;
    unsigned fileBufSize;
    // Allocate Memory in Host Memory
    std::vector<int,aligned_allocator<int>> source_a_0(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_a_1(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_a_2(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_a_3(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_a_4(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_a_5(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_a_6(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_a_7(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_a_8(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_b_0(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_b_1(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_b_2(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_b_3(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_b_4(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_b_5(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_b_6(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_b_7(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_b_8(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_hw_results_0(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_hw_results_1(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_hw_results_2(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_hw_results_3(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_hw_results_4(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_hw_results_5(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_hw_results_6(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_hw_results_7(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_hw_results_8(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_sw_results_0(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_sw_results_1(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_sw_results_2(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_sw_results_3(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_sw_results_4(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_sw_results_5(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_sw_results_6(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_sw_results_7(DATA_SIZE);
    std::vector<int,aligned_allocator<int>> source_sw_results_8(DATA_SIZE);

    // Create the test data 
    for(int i = 0 ; i < DATA_SIZE ; i++){
        source_a_0[i] = rand() % DATA_SIZE;
        source_a_1[i] = rand() % DATA_SIZE;
        source_a_2[i] = rand() % DATA_SIZE;
        source_a_3[i] = rand() % DATA_SIZE;
        source_a_4[i] = rand() % DATA_SIZE;
        source_a_5[i] = rand() % DATA_SIZE;
        source_a_6[i] = rand() % DATA_SIZE;
        source_a_7[i] = rand() % DATA_SIZE;
        source_a_8[i] = rand() % DATA_SIZE;
        source_b_0[i] = rand() % DATA_SIZE;
        source_b_1[i] = rand() % DATA_SIZE;
        source_b_2[i] = rand() % DATA_SIZE;
        source_b_3[i] = rand() % DATA_SIZE;
        source_b_4[i] = rand() % DATA_SIZE;
        source_b_5[i] = rand() % DATA_SIZE;
        source_b_6[i] = rand() % DATA_SIZE;
        source_b_7[i] = rand() % DATA_SIZE;
        source_b_8[i] = rand() % DATA_SIZE;
        source_sw_results_0[i] = source_a_0[i] + source_b_0[i];
        source_sw_results_1[i] = source_a_1[i] + source_b_1[i];
        source_sw_results_2[i] = source_a_2[i] + source_b_2[i];
        source_sw_results_3[i] = source_a_3[i] + source_b_3[i];
        source_sw_results_4[i] = source_a_4[i] + source_b_4[i];
        source_sw_results_5[i] = source_a_5[i] + source_b_5[i];
        source_sw_results_6[i] = source_a_6[i] + source_b_6[i];
        source_sw_results_7[i] = source_a_7[i] + source_b_7[i];
        source_sw_results_8[i] = source_a_8[i] + source_b_8[i];
        source_hw_results_0[i] = 10;
        source_hw_results_1[i] = 10;
        source_hw_results_2[i] = 10;
        source_hw_results_3[i] = 10;
        source_hw_results_4[i] = 10;
        source_hw_results_5[i] = 10;
        source_hw_results_6[i] = 10;
        source_hw_results_7[i] = 10;
        source_hw_results_8[i] = 10;
    }

// OPENCL HOST CODE AREA START
	
// ------------------------------------------------------------------------------------
// Step 1: Get All PLATFORMS, then search for Target_Platform_Vendor (CL_PLATFORM_VENDOR)
//	   Search for Platform: Xilinx 
// Check if the current platform matches Target_Platform_Vendor
// ------------------------------------------------------------------------------------	
    std::vector<cl::Device> devices = get_devices("Xilinx");
    devices.resize(1);
    cl::Device device = devices[0];

// ------------------------------------------------------------------------------------
// Step 1: Create Context
// ------------------------------------------------------------------------------------
    OCL_CHECK(err, cl::Context context(device, NULL, NULL, NULL, &err));
	
// ------------------------------------------------------------------------------------
// Step 1: Create Command Queue
// ------------------------------------------------------------------------------------
    OCL_CHECK(err, cl::CommandQueue q(context, device, CL_QUEUE_PROFILING_ENABLE, &err));

// ------------------------------------------------------------------
// Step 1: Load Binary File from disk
// ------------------------------------------------------------------		
    char* fileBuf = read_binary_file(binaryFile, fileBufSize);
    cl::Program::Binaries bins{{fileBuf, fileBufSize}};
	
// -------------------------------------------------------------
// Step 1: Create the program object from the binary and program the FPGA device with it
// -------------------------------------------------------------	
    OCL_CHECK(err, cl::Program program(context, devices, bins, NULL, &err));

// -------------------------------------------------------------
// Step 1: Create Kernels
// -------------------------------------------------------------
    OCL_CHECK(err, cl::Kernel krnl_vector_add(program,"vadd", &err));

// ================================================================
// Step 2: Setup Buffers and run Kernels
// ================================================================
//   o) Allocate Memory to store the results 
//   o) Create Buffers in Global Memory to store data
// ================================================================

// ------------------------------------------------------------------
// Step 2: Create Buffers in Global Memory to store data
//             o) buffer_in1 - stores source_in1
//             o) buffer_in2 - stores source_in2
//             o) buffer_ouput - stores Results
// ------------------------------------------------------------------	

// .......................................................
// Allocate Global Memory for source_in1
// .......................................................	
    OCL_CHECK(err, cl::Buffer buffer_a_0 (context,CL_MEM_USE_HOST_PTR | CL_MEM_READ_ONLY, vector_size_bytes, source_a_0.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_a_1 (context,CL_MEM_USE_HOST_PTR | CL_MEM_READ_ONLY, vector_size_bytes, source_a_1.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_a_2 (context,CL_MEM_USE_HOST_PTR | CL_MEM_READ_ONLY, vector_size_bytes, source_a_2.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_a_3 (context,CL_MEM_USE_HOST_PTR | CL_MEM_READ_ONLY, vector_size_bytes, source_a_3.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_a_4 (context,CL_MEM_USE_HOST_PTR | CL_MEM_READ_ONLY, vector_size_bytes, source_a_4.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_a_5 (context,CL_MEM_USE_HOST_PTR | CL_MEM_READ_ONLY, vector_size_bytes, source_a_5.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_a_6 (context,CL_MEM_USE_HOST_PTR | CL_MEM_READ_ONLY, vector_size_bytes, source_a_6.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_a_7 (context,CL_MEM_USE_HOST_PTR | CL_MEM_READ_ONLY, vector_size_bytes, source_a_7.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_a_8 (context,CL_MEM_USE_HOST_PTR | CL_MEM_READ_ONLY, vector_size_bytes, source_a_8.data(), &err));
// .......................................................
// Allocate Global Memory for source_in2
// .......................................................
    OCL_CHECK(err, cl::Buffer buffer_b_0 (context,CL_MEM_USE_HOST_PTR | CL_MEM_READ_ONLY, vector_size_bytes, source_b_0.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_b_1 (context,CL_MEM_USE_HOST_PTR | CL_MEM_READ_ONLY, vector_size_bytes, source_b_1.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_b_2 (context,CL_MEM_USE_HOST_PTR | CL_MEM_READ_ONLY, vector_size_bytes, source_b_2.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_b_3 (context,CL_MEM_USE_HOST_PTR | CL_MEM_READ_ONLY, vector_size_bytes, source_b_3.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_b_4 (context,CL_MEM_USE_HOST_PTR | CL_MEM_READ_ONLY, vector_size_bytes, source_b_4.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_b_5 (context,CL_MEM_USE_HOST_PTR | CL_MEM_READ_ONLY, vector_size_bytes, source_b_5.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_b_6 (context,CL_MEM_USE_HOST_PTR | CL_MEM_READ_ONLY, vector_size_bytes, source_b_6.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_b_7 (context,CL_MEM_USE_HOST_PTR | CL_MEM_READ_ONLY, vector_size_bytes, source_b_7.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_b_8 (context,CL_MEM_USE_HOST_PTR | CL_MEM_READ_ONLY, vector_size_bytes, source_b_8.data(), &err));
// .......................................................
// Allocate Global Memory for sourcce_hw_results
// .......................................................
    OCL_CHECK(err, cl::Buffer buffer_output_0(context,CL_MEM_USE_HOST_PTR | CL_MEM_WRITE_ONLY, 
            vector_size_bytes, source_hw_results_0.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_output_1(context,CL_MEM_USE_HOST_PTR | CL_MEM_WRITE_ONLY, 
            vector_size_bytes, source_hw_results_1.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_output_2(context,CL_MEM_USE_HOST_PTR | CL_MEM_WRITE_ONLY, 
            vector_size_bytes, source_hw_results_2.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_output_3(context,CL_MEM_USE_HOST_PTR | CL_MEM_WRITE_ONLY, 
            vector_size_bytes, source_hw_results_3.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_output_4(context,CL_MEM_USE_HOST_PTR | CL_MEM_WRITE_ONLY, 
            vector_size_bytes, source_hw_results_4.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_output_5(context,CL_MEM_USE_HOST_PTR | CL_MEM_WRITE_ONLY, 
            vector_size_bytes, source_hw_results_5.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_output_6(context,CL_MEM_USE_HOST_PTR | CL_MEM_WRITE_ONLY, 
            vector_size_bytes, source_hw_results_6.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_output_7(context,CL_MEM_USE_HOST_PTR | CL_MEM_WRITE_ONLY, 
            vector_size_bytes, source_hw_results_7.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_output_8(context,CL_MEM_USE_HOST_PTR | CL_MEM_WRITE_ONLY, 
            vector_size_bytes, source_hw_results_8.data(), &err));

// ============================================================================
// Step 2: Set Kernel Arguments and Run the Application
//         o) Set Kernel Arguments
//              ----------------------------------------------------
//              Kernel Argument  Description
//              ----------------------------------------------------
//              in1   (input)     --> Input Vector1
//              in2   (input)     --> Input Vector2
//              out   (output)    --> Output Vector
//              size  (input)     --> Size of Vector in Integer
//         o) Copy Input Data from Host to Global Memory on the device
//         o) Submit Kernels for Execution
//         o) Copy Results from Global Memory, device to Host
// ============================================================================	
    int size = DATA_SIZE;
    OCL_CHECK(err, err = krnl_vector_add.setArg(0, size));
    
    OCL_CHECK(err, err = krnl_vector_add.setArg(1, buffer_a_0));
    OCL_CHECK(err, err = krnl_vector_add.setArg(2, buffer_b_0));
    OCL_CHECK(err, err = krnl_vector_add.setArg(3, buffer_output_0));
    
    OCL_CHECK(err, err = krnl_vector_add.setArg(4, buffer_a_1));
    OCL_CHECK(err, err = krnl_vector_add.setArg(5, buffer_b_1));
    OCL_CHECK(err, err = krnl_vector_add.setArg(6, buffer_output_1));
    
    OCL_CHECK(err, err = krnl_vector_add.setArg(7, buffer_a_2));
    OCL_CHECK(err, err = krnl_vector_add.setArg(8, buffer_b_2));
    OCL_CHECK(err, err = krnl_vector_add.setArg(9, buffer_output_2));
    
    OCL_CHECK(err, err = krnl_vector_add.setArg(10, buffer_a_3));
    OCL_CHECK(err, err = krnl_vector_add.setArg(11, buffer_b_3));
    OCL_CHECK(err, err = krnl_vector_add.setArg(12, buffer_output_3));
    
    OCL_CHECK(err, err = krnl_vector_add.setArg(13, buffer_a_4));
    OCL_CHECK(err, err = krnl_vector_add.setArg(14, buffer_b_4));
    OCL_CHECK(err, err = krnl_vector_add.setArg(15, buffer_output_4));
    
    OCL_CHECK(err, err = krnl_vector_add.setArg(16, buffer_a_5));
    OCL_CHECK(err, err = krnl_vector_add.setArg(17, buffer_b_5));
    OCL_CHECK(err, err = krnl_vector_add.setArg(18, buffer_output_5));
    
    OCL_CHECK(err, err = krnl_vector_add.setArg(19, buffer_a_6));
    OCL_CHECK(err, err = krnl_vector_add.setArg(20, buffer_b_6));
    OCL_CHECK(err, err = krnl_vector_add.setArg(21, buffer_output_6));
    
    OCL_CHECK(err, err = krnl_vector_add.setArg(22, buffer_a_7));
    OCL_CHECK(err, err = krnl_vector_add.setArg(23, buffer_b_7));
    OCL_CHECK(err, err = krnl_vector_add.setArg(24, buffer_output_7));
    
    OCL_CHECK(err, err = krnl_vector_add.setArg(25, buffer_a_8));
    OCL_CHECK(err, err = krnl_vector_add.setArg(26, buffer_b_8));
    OCL_CHECK(err, err = krnl_vector_add.setArg(27, buffer_output_8));
    
// ------------------------------------------------------
// Step 2: Copy Input data from Host to Global Memory on the device
// ------------------------------------------------------
    OCL_CHECK(err, err = q.enqueueMigrateMemObjects({buffer_a_0,
                                                     buffer_a_1,
                                                     buffer_a_2,
                                                     buffer_a_3,
                                                     buffer_a_4,
                                                     buffer_a_5,
                                                     buffer_a_6,
                                                     buffer_a_7,
                                                     buffer_a_8,
                                                     buffer_b_0,
                                                     buffer_b_1,
                                                     buffer_b_2,
                                                     buffer_b_3,
                                                     buffer_b_4,
                                                     buffer_b_5,
                                                     buffer_b_6,
                                                     buffer_b_7,
                                                     buffer_b_8 },0/* 0 means from host*/));	

// ----------------------------------------
// Step 2: Submit Kernels for Execution
// ----------------------------------------
    OCL_CHECK(err, err = q.enqueueTask(krnl_vector_add));
	
// --------------------------------------------------
// Step 2: Copy Results from Device Global Memory to Host
// --------------------------------------------------
    OCL_CHECK(err, err = q.enqueueMigrateMemObjects({buffer_output_0,
                                                     buffer_output_1,
                                                     buffer_output_2,
                                                     buffer_output_3,
                                                     buffer_output_4,
                                                     buffer_output_5,
                                                     buffer_output_6,
                                                     buffer_output_7,
                                                     buffer_output_8},CL_MIGRATE_MEM_OBJECT_HOST));

    q.finish();
	
// OPENCL HOST CODE AREA END

    // Compare the results of the Device to the simulation
    bool match = true;
    for (int i = 0 ; i < DATA_SIZE ; i++){
        if (source_hw_results_0[i] != source_sw_results_0[i]){
            std::cout << "Error: Result mismatch" << std::endl;
            std::cout << "i = " << i << " CPU result = " << source_sw_results_0[i]
                << " Device result = " << source_hw_results_0[i] << std::endl;
            match = false;
            break;
        }
        if (source_hw_results_1[i] != source_sw_results_1[i]){
            std::cout << "Error: Result mismatch" << std::endl;
            std::cout << "i = " << i << " CPU result = " << source_sw_results_1[i]
                << " Device result = " << source_hw_results_1[i] << std::endl;
            match = false;
            break;
        }
        if (source_hw_results_2[i] != source_sw_results_2[i]){
            std::cout << "Error: Result mismatch" << std::endl;
            std::cout << "i = " << i << " CPU result = " << source_sw_results_2[i]
                << " Device result = " << source_hw_results_2[i] << std::endl;
            match = false;
            break;
        }
        if (source_hw_results_3[i] != source_sw_results_3[i]){
            std::cout << "Error: Result mismatch" << std::endl;
            std::cout << "i = " << i << " CPU result = " << source_sw_results_3[i]
                << " Device result = " << source_hw_results_3[i] << std::endl;
            match = false;
            break;
        }
        if (source_hw_results_4[i] != source_sw_results_4[i]){
            std::cout << "Error: Result mismatch" << std::endl;
            std::cout << "i = " << i << " CPU result = " << source_sw_results_4[i]
                << " Device result = " << source_hw_results_4[i] << std::endl;
            match = false;
            break;
        }
        if (source_hw_results_5[i] != source_sw_results_5[i]){
            std::cout << "Error: Result mismatch" << std::endl;
            std::cout << "i = " << i << " CPU result = " << source_sw_results_5[i]
                << " Device result = " << source_hw_results_5[i] << std::endl;
            match = false;
            break;
        }
        if (source_hw_results_6[i] != source_sw_results_6[i]){
            std::cout << "Error: Result mismatch" << std::endl;
            std::cout << "i = " << i << " CPU result = " << source_sw_results_6[i]
                << " Device result = " << source_hw_results_6[i] << std::endl;
            match = false;
            break;
        }
        if (source_hw_results_7[i] != source_sw_results_7[i]){
            std::cout << "Error: Result mismatch" << std::endl;
            std::cout << "i = " << i << " CPU result = " << source_sw_results_7[i]
                << " Device result = " << source_hw_results_7[i] << std::endl;
            match = false;
            break;
        }
        if (source_hw_results_8[i] != source_sw_results_8[i]){
            std::cout << "Error: Result mismatch" << std::endl;
            std::cout << "i = " << i << " CPU result = " << source_sw_results_8[i]
                << " Device result = " << source_hw_results_8[i] << std::endl;
            match = false;
            break;
        }
    }
	
// ============================================================================
// Step 3: Release Allocated Resources
// ============================================================================
    delete[] fileBuf;

    std::cout << "TEST " << (match ? "PASSED" : "FAILED") << std::endl; 
    return (match ? EXIT_SUCCESS : EXIT_FAILURE);
}

