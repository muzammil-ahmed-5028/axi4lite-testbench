`include "uvm_macros.svh"
import uvm_pkg::*;

`ifndef IF_AXI
`define IF_AXI
interface axi4_lite_if(input logic ACLK, input logic ARESETN);
    // Control Signals (Master Inputs)
    logic        START_READ;
    logic        START_WRITE;
    logic [31:0] address;
    logic [31:0] W_data;
  
    // AXI4-Lite Signals
    // Read Address Channel
    logic [31:0] M_ARADDR;
    logic        M_ARVALID;
    logic        M_ARREADY;
  
    // Read Data Channel
    logic [31:0] M_RDATA;
    logic  [1:0] M_RRESP;
    logic        M_RVALID;
    logic        M_RREADY;
  
    // Write Address Channel
    logic [31:0] M_AWADDR;
    logic        M_AWVALID;
    logic        M_AWREADY;
  
    // Write Data Channel
    logic [31:0] M_WDATA;
    logic  [3:0] M_WSTRB;
    logic        M_WVALID;
    logic        M_WREADY;
  
    // Write Response Channel
    logic  [1:0] M_BRESP;
    logic        M_BVALID;
    logic        M_BREADY;
  
    // Modports for Master and Slave
    modport MST (
      // Control Inputs
      input  START_READ,
      input  START_WRITE,
      input  address,
      input  W_data,
      // AXI Outputs
      output M_ARADDR,
      output M_ARVALID,
      output M_AWADDR,
      output M_AWVALID,
      output M_WDATA,
      output M_WSTRB,
      output M_WVALID,
      output M_BREADY,
      output M_RREADY,
      // AXI Inputs
      input  M_ARREADY,
      input  M_RDATA,
      input  M_RRESP,
      input  M_RVALID,
      input  M_AWREADY,
      input  M_WREADY,
      input  M_BRESP,
      input  M_BVALID
    );
  
    modport SLV (
      // AXI Inputs
      input  M_ARADDR,
      input  M_ARVALID,
      input  M_AWADDR,
      input  M_AWVALID,
      input  M_WDATA,
      input  M_WSTRB,
      input  M_WVALID,
      input  M_BREADY,
      input  M_RREADY,
      // AXI Outputs
      output M_ARREADY,
      output M_RDATA,
      output M_RRESP,
      output M_RVALID,
      output M_AWREADY,
      output M_WREADY,
      output M_BRESP,
      output M_BVALID
    );
  endinterface
`endif