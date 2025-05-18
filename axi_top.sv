module axi4_lite_top#(
    parameter DATA_WIDTH = 32,
    parameter ADDRESS = 32
    )(
        // Global Signals
        input                           ACLK,
        input                           ARESETN,
        // Control Signals
        input                           read_s,
        input                           write_s,
        input    [ADDRESS-1:0]          address,
        input    [DATA_WIDTH-1:0]       W_data,
        // AXI4-Lite Master Interface Ports
        output logic [ADDRESS-1 : 0]    M_ARADDR,
        output logic                    M_ARVALID,
        input                           M_ARREADY,
        input  [DATA_WIDTH-1:0]         M_RDATA,
        input  [1:0]                    M_RRESP,
        input                           M_RVALID,
        output logic                    M_RREADY,
        output logic [ADDRESS-1 : 0]    M_AWADDR,
        output logic                    M_AWVALID,
        input                           M_AWREADY,
        output logic [DATA_WIDTH-1:0]   M_WDATA,
        output logic [3:0]              M_WSTRB,
        output logic                    M_WVALID,
        input                           M_WREADY,
        input  [1:0]                   M_BRESP,
        input                           M_BVALID,
        output logic                    M_BREADY
    );

    // Internal signals removed since ports are now directly connected

    axi4_lite_master u_axi4_lite_master0 (
        .ACLK(ACLK),
        .ARESETN(ARESETN),
        .START_READ(read_s),
        .START_WRITE(write_s),
        .address(address),
        .W_data(W_data),
        // AXI4-Lite Ports
        .M_ARADDR(M_ARADDR),
        .M_ARVALID(M_ARVALID),
        .M_ARREADY(M_ARREADY),
        .M_RDATA(M_RDATA),
        .M_RRESP(M_RRESP),
        .M_RVALID(M_RVALID),
        .M_RREADY(M_RREADY),
        .M_AWADDR(M_AWADDR),
        .M_AWVALID(M_AWVALID),
        .M_AWREADY(M_AWREADY),
        .M_WDATA(M_WDATA),
        .M_WSTRB(M_WSTRB),
        .M_WVALID(M_WVALID),
        .M_WREADY(M_WREADY),
        .M_BRESP(M_BRESP),
        .M_BVALID(M_BVALID),
        .M_BREADY(M_BREADY)
    );

    axi4_lite_slave u_axi4_lite_slave0 (
        .ACLK(ACLK),
        .ARESETN(ARESETN),
        // AXI4-Lite Ports
        .S_ARADDR(M_ARADDR),
        .S_ARVALID(M_ARVALID),
        .S_ARREADY(M_ARREADY),
        .S_RDATA(M_RDATA),
        .S_RRESP(M_RRESP),
        .S_RVALID(M_RVALID),
        .S_RREADY(M_RREADY),
        .S_AWADDR(M_AWADDR),
        .S_AWVALID(M_AWVALID),
        .S_AWREADY(M_AWREADY),
        .S_WDATA(M_WDATA),
        .S_WSTRB(M_WSTRB),
        .S_WVALID(M_WVALID),
        .S_WREADY(M_WREADY),
        .S_BRESP(M_BRESP),
        .S_BVALID(M_BVALID),
        .S_BREADY(M_BREADY)
    );
endmodule