`timescale 1ns / 1ps

module check(); 

    // 1. Define Clock and Reset
    reg clk;
    reg resetn;

    // 2. AXI-Lite Signals
    reg [5:0] awaddr;
    reg [2:0] awprot;
    reg awvalid;
    wire awready;
    reg [31:0] wdata;
    reg [3:0] wstrb;
    reg wvalid;
    wire wready;
    wire [1:0] bresp;
    wire bvalid;
    reg bready;
    
    // Read signals (tied off for this write-only test)
    reg [5:0] araddr = 0;
    reg [2:0] arprot = 0;
    reg arvalid = 0;
    wire arready;
    wire [31:0] rdata;
    wire [1:0] rresp;
    wire rvalid;
    reg rready = 1;

    // 3. Instantiate the TOP LEVEL Wrapper
    aes_ecb_wrapper uut (
        .s00_axi_aclk(clk),
        .s00_axi_aresetn(resetn),
        .s00_axi_awaddr(awaddr),
        .s00_axi_awprot(awprot),
        .s00_axi_awvalid(awvalid),
        .s00_axi_awready(awready),
        .s00_axi_wdata(wdata),
        .s00_axi_wstrb(wstrb),
        .s00_axi_wvalid(wvalid),
        .s00_axi_wready(wready),
        .s00_axi_bresp(bresp),
        .s00_axi_bvalid(bvalid),
        .s00_axi_bready(bready),
        .s00_axi_araddr(araddr),
        .s00_axi_arprot(arprot),
        .s00_axi_arvalid(arvalid),
        .s00_axi_arready(arready),
        .s00_axi_rdata(rdata),
        .s00_axi_rresp(rresp),
        .s00_axi_rvalid(rvalid),
        .s00_axi_rready(rready)
    );

    // 4. Generate a 100MHz Clock
    always #5 clk = ~clk;

    // 5. AXI Write Task 
    task axi_write(input [5:0] addr, input [31:0] data);
        begin
            @(posedge clk);
            awaddr = addr; awvalid = 1;
            wdata = data; wvalid = 1; wstrb = 4'hF;
            wait(awready && wready);
            @(posedge clk);
            awvalid = 0; wvalid = 0; bready = 1;
            wait(bvalid);
            @(posedge clk);
            bready = 0;
        end
    endtask

    // 6. The Actual Test Sequence
    initial begin
        // Initialize everything to zero
        clk = 0; resetn = 0;
        awaddr = 0; awvalid = 0; awprot = 0;
        wdata = 0; wvalid = 0; wstrb = 0; bready = 0;

        // Release Reset
        #20 resetn = 1;
        #20;

        // Send Key
        axi_write(6'h00, 32'h09CF4F3C);
        axi_write(6'h04, 32'hABF71588);
        axi_write(6'h08, 32'h28AED2A6);
        axi_write(6'h0C, 32'h2B7E1516);

        // Send Plaintext 
        axi_write(6'h10, 32'h7393172A);
        axi_write(6'h14, 32'hE93D7E11);
        axi_write(6'h18, 32'h2E409F96);
        axi_write(6'h1C, 32'h6BC1BEE2);

        // Send Start Trigger (Register 8 = 0x20)
        axi_write(6'h20, 32'h00000007);

        #500;
        $finish;
    end
endmodule