`include "interface.sv"
`include "sequence.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;


class axi4_lite_driver extends uvm_driver #(axi4_lite_seq_item);
    `uvm_component_utils(axi4_lite_driver)
    virtual axi4_lite_if.MST vif;  // Use MST modport
  
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
  
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if (!uvm_config_db#(virtual axi4_lite_if.MST)::get(this, "", "vif", vif))
        `uvm_fatal("NO_VIF", "Virtual interface not set!")
    endfunction
  
    task run_phase(uvm_phase phase);
      forever begin
        seq_item_port.get_next_item(req);
        drive_transaction(req);
        seq_item_port.item_done();
      end
    endtask
  
    task drive_transaction(axi4_lite_seq_item req);
      // Apply control signals
      vif.START_READ  <= 0;
      vif.START_WRITE <= 0;
      vif.address     <= req.addr;
      vif.W_data      <= req.data;
  
      // Wait for requested delay
      repeat(req.delay) @(posedge vif.ACLK);
  
      // Drive transaction
      if (req.is_write) begin
        vif.START_WRITE <= 1;
        @(posedge vif.ACLK iff vif.M_AWREADY && vif.M_WREADY);
        vif.START_WRITE <= 0;
      end else begin
        vif.START_READ <= 1;
        @(posedge vif.ACLK iff vif.M_ARREADY);
        vif.START_READ <= 0;
      end
    endtask
  endclass