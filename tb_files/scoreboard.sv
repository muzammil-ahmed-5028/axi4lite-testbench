`include "sequence.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;


class axi4_lite_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(axi4_lite_scoreboard)
    uvm_analysis_imp #(axi4_lite_seq_item, axi4_lite_scoreboard) sb_ap;
    logic [31:0] reg_model[32]; // Mirror of slave's register array
  
    function new(string name, uvm_component parent);
      super.new(name, parent);
      sb_ap = new("sb_ap", this);
    endfunction
  
    virtual function void write(axi4_lite_seq_item tr);
      if (tr.is_write) begin
        reg_model[tr.addr] = tr.data;
        `uvm_info("SCOREBOARD", $sformatf("Write: Addr=0x%0h Data=0x%0h", tr.addr, tr.data), UVM_LOW)
      end else begin
        if (reg_model[tr.addr] != tr.data)
          `uvm_error("SCOREBOARD", $sformatf("Read mismatch: Exp=0x%0h Act=0x%0h", reg_model[tr.addr], tr.data))
        else
          `uvm_info("SCOREBOARD", $sformatf("Read match: Addr=0x%0h Data=0x%0h", tr.addr, tr.data), UVM_LOW)
      end
    endfunction
  endclass