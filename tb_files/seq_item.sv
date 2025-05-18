`include "uvm_macros.svh"
import uvm_pkg::*;

`ifndef SEQ_ITEM_SV
`define SEQ_ITEM_SV

class axi4_lite_seq_item extends uvm_sequence_item;
    rand logic [31:0] addr;
    rand logic [31:0] data;
    rand bit          is_write;
  
    // Control fields for handshake timing
    rand int delay;
  
    // Response fields
    logic [1:0] resp;
  
    `uvm_object_utils_begin(axi4_lite_seq_item)
      `uvm_field_int(addr, UVM_ALL_ON)
      `uvm_field_int(data, UVM_ALL_ON)
      `uvm_field_int(is_write, UVM_ALL_ON)
      `uvm_field_int(delay, UVM_ALL_ON)
      `uvm_field_int(resp, UVM_ALL_ON)
    `uvm_object_utils_end
  
    function new(string name = "axi4_lite_seq_item");
      super.new(name);
    endfunction
  endclass
  `endif