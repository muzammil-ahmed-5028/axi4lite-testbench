`include "test.sv"
module tb_top;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
  
    // Clock and Reset
    logic ACLK = 0;
    logic ARESETN = 0;
  
    // Instantiate Interface
    axi4_lite_if axi4_if(ACLK, ARESETN);
  
    // Instantiate DUT
    axi4_lite_top dut (
    .ACLK(ACLK),
    .ARESETN(ARESETN),
    // Control Signals
    .read_s(axi4_if.START_READ),
    .write_s(axi4_if.START_WRITE),
    .address(axi4_if.address),
    .W_data(axi4_if.W_data),
    // AXI4-Lite Master Interface
    .M_ARADDR(axi4_if.M_ARADDR),
    .M_ARVALID(axi4_if.M_ARVALID),
    .M_ARREADY(axi4_if.M_ARREADY),
    .M_RDATA(axi4_if.M_RDATA),
    .M_RRESP(axi4_if.M_RRESP),
    .M_RVALID(axi4_if.M_RVALID),
    .M_RREADY(axi4_if.M_RREADY),
    .M_AWADDR(axi4_if.M_AWADDR),
    .M_AWVALID(axi4_if.M_AWVALID),
    .M_AWREADY(axi4_if.M_AWREADY),
    .M_WDATA(axi4_if.M_WDATA),
    .M_WSTRB(axi4_if.M_WSTRB),
    .M_WVALID(axi4_if.M_WVALID),
    .M_WREADY(axi4_if.M_WREADY),
    .M_BRESP(axi4_if.M_BRESP),
    .M_BVALID(axi4_if.M_BVALID),
    .M_BREADY(axi4_if.M_BREADY)
  );
  
    // Clock Generation
    always #5 ACLK = ~ACLK;
  
    initial begin
      // Pass interface to UVM
      uvm_config_db#(virtual axi4_lite_if.MST)::set(null, "uvm_test_top.env.agent.drv", "vif", axi4_if);
      uvm_config_db#(virtual axi4_lite_if.SLV)::set(null, "uvm_test_top.env.agent.mon", "vif", axi4_if);
  
      // Reset Sequence
      ARESETN = 0;
      #20 ARESETN = 1;
  
      // Run Test
      run_test("axi4_lite_test");
    end
  endmodule