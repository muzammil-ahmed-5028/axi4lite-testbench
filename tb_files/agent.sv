`include "Sequencer.sv"
`include "monitor.sv"
`include "driver.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;

class axi4_lite_agent extends uvm_agent;
    `uvm_component_utils(axi4_lite_agent)
    axi4_lite_sequencer sqr;
    axi4_lite_driver    drv;
    axi4_lite_monitor   mon;
  
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
  
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      sqr = axi4_lite_sequencer::type_id::create("sqr", this);
      drv = axi4_lite_driver::type_id::create("drv", this);
      mon = axi4_lite_monitor::type_id::create("mon", this);
    endfunction
  
    virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction
  endclass