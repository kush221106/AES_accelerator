AES-128 Hardware Accelerator
Overview
Designed and implemented a fully pipelined AES-128 encryption engine in Verilog, compliant with the FIPS-197 standard. The accelerator is deployed on a Zynq-7000 SoC (ZedBoard) and validated against official NIST test vectors.

Key Features
RTL Design & Architecture

Implemented complete AES-128 encryption across 10 fully unrolled pipeline stages in Verilog, enabling single-cycle throughput after an initial 11-cycle latency
Each pipeline stage performs one full AES round including SubBytes, ShiftRows, MixColumns, and AddRoundKey transformations
Designed dedicated key expansion logic running parallel to the datapath, eliminating key scheduling overhead
Achieved maximum data throughput by eliminating pipeline stalls through continuous valid/start signal architecture

Verification & Testing

Functionally verified the RTL design using ModelSim/Vivado simulation with standard FIPS-197 test vectors
Confirmed correct encryption output matching all four official NIST plaintext-ciphertext pairs for the standard 128-bit key
Validated pipeline behavior by feeding multiple consecutive plaintext blocks and verifying ordered cipher output

FPGA Implementation

Synthesized and implemented the design on Xilinx Zynq-7000 SoC (xc7z020) targeting the ZedBoard evaluation platform using Vivado 2025.2
Successfully met timing closure at 100MHz PL fabric clock with zero timing violations
Verified hardware functionality on physical FPGA by matching cipher output against NIST standard test vectors

PS-PL Integration via AXI4-Lite

Wrapped the AES core with a custom AXI4-Lite slave interface for seamless integration with the Zynq ARM Cortex-A9 processor
Designed a 9-register memory-mapped interface exposing key input, plaintext input, ciphertext output, control, and status registers
Integrated the AES wrapper into a Vivado block design connecting the Zynq PS to PL fabric via AXI SmartConnect

System Architecture

Utilized Zynq PS-PL AXI interface for high-speed communication between ARM processor and FPGA fabric
Implemented asymmetric read/write register mapping — write path loads key/plaintext into pipeline, read path returns live cipher output directly from AES core output ports
Validated end-to-end system including PS initialization, AXI transactions, pipeline execution, and result readback


Tools & Technologies
RTL Design:      Verilog HDL
Simulation:      Vivado Simulator
Synthesis:       Vivado 2025.2
Target Device:   Xilinx Zynq-7000 (xc7z020) — ZedBoard
PS Software:     (Vitis IDE 2025.2)
Protocol:        AXI4-Lite
Standard:        FIPS-197 / NIST AES-128
Clock:           100MHz (PL) / 666MHz (PS)

Results

Hardware cipher output matched NIST expected output with 100% accuracy
