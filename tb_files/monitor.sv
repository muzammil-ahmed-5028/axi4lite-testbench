`include "interface.sv"
`include "sequence.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;


class axi4_lite_monitor extends uvm_monitor;
    `uvm_component_utils(axi4_lite_monitor)
    virtual axi4_lite_if.SLV vif;  // Use SLV modport
    uvm_analysis_port #(axi4_lite_seq_item) mon_ap;
  
    function new(string name, uvm_component parent);
      super.new(name, parent);
      mon_ap = new("mon_ap", this);
    endfunction
  
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if (!uvm_config_db#(virtual axi4_lite_if.SLV)::get(this, "", "vif", vif))
        `uvm_fatal("NO_VIF", "Virtual interface not set!")
    endfunction
  
    task run_phase(uvm_phase phase);
      forever begin
        axi4_lite_seq_item tr = axi4_lite_seq_item::type_id::create("tr");
        capture_transaction(tr);
        mon_ap.write(tr);
      end
    endtask
  
    task capture_transaction(axi4_lite_seq_item tr);
      fork
        // Write Address Handshake
        begin
          @(posedge vif.ACLK iff vif.M_AWVALID && vif.M_AWREADY);
          tr.is_write = 1;
          tr.addr     = vif.M_AWADDR;
        end
        // Write Data Handshake
        begin
          @(posedge vif.ACLK iff vif.M_WVALID && vif.M_WREADY);
          tr.data     = vif.M_WDATA;
        end
        // Read Address Handshake
        begin
          @(posedge vif.ACLK iff vif.M_ARVALID && vif.M_ARREADY);
          tr.is_write = 0;
          tr.addr     = vif.M_ARADDR;
        end
        // Read Data Handshake
        begin
          @(posedge vif.ACLK iff vif.M_RVALID && vif.M_RREADY);
          tr.data     = vif.M_RDATA;
          tr.resp     = vif.M_RRESP;
        end
      join_any
      disable fork;
    endtask
  endclass