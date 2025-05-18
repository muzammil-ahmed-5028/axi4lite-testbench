`include "sequence.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;

class axi4_lite_sequencer extends uvm_sequencer #(axi4_lite_seq_item);
    `uvm_component_utils(axi4_lite_sequencer)
  
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
  endclass