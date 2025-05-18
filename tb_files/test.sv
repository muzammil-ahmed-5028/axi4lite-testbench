`include "uvm_macros.svh"
import uvm_pkg::*;
`include "enviroment.sv"

class axi4_lite_test extends uvm_test;
    `uvm_component_utils(axi4_lite_test)
    axi4_lite_env env;
  
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
  
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = axi4_lite_env::type_id::create("env", this);
    endfunction
  
    task run_phase(uvm_phase phase);
      axi4_lite_write_seq write_seq;
      axi4_lite_read_seq  read_seq;
  
      phase.raise_objection(this);
      write_seq = axi4_lite_write_seq::type_id::create("write_seq");
      read_seq  = axi4_lite_read_seq::type_id::create("read_seq");
  
      // Write followed by read
      write_seq.start(env.agent.sqr);
      read_seq.start(env.agent.sqr);
      phase.drop_objection(this);
    endtask
  endclass