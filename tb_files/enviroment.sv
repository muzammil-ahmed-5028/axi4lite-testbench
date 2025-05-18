`include "uvm_macros.svh"
import uvm_pkg::*;
`include "agent.sv"
`include "scoreboard.sv"
class axi4_lite_env extends uvm_env;
    `uvm_component_utils(axi4_lite_env)
    axi4_lite_agent    agent;
    axi4_lite_scoreboard sb;
  
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
  
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      agent = axi4_lite_agent::type_id::create("agent", this);
      sb    = axi4_lite_scoreboard::type_id::create("sb", this);
    endfunction
  
    virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      agent.mon.mon_ap.connect(sb.sb_ap);
    endfunction
  endclass