`include "seq_item.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;

`ifndef SEQUENCER_SV
`define SEQUENCER_SV
class axi4_lite_base_sequence extends uvm_sequence #(axi4_lite_seq_item);
    `uvm_object_utils(axi4_lite_base_sequence)
  
    function new(string name = "axi4_lite_base_sequence");
      super.new(name);
    endfunction
  
    task body();
      `uvm_error("BASE_SEQ", "This base sequence should not be executed directly!")
    endtask
  endclass
  
  // Write Sequence
  class axi4_lite_write_seq extends axi4_lite_base_sequence;
    `uvm_object_utils(axi4_lite_write_seq)
  
    function new(string name = "axi4_lite_write_seq");
      super.new(name);
    endfunction
  
    task body();
      axi4_lite_seq_item req;
      req = axi4_lite_seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {is_write == 1;});
      finish_item(req);
    endtask
  endclass
  
  // Read Sequence
  class axi4_lite_read_seq extends axi4_lite_base_sequence;
    `uvm_object_utils(axi4_lite_read_seq)
  
    function new(string name = "axi4_lite_read_seq");
      super.new(name);
    endfunction
  
    task body();
      axi4_lite_seq_item req;
      req = axi4_lite_seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {is_write == 0;});
      finish_item(req);
    endtask
  endclass

`endif