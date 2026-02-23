/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

//////Integrate-and-fire neuron///////

`default_nettype none

module tt_um_iaf_neuron (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  assign uio_out [6:0] = 0;         // MSB used for spike output, rest unused         
  assign uio_oe  = 1;

  wire spike_out;
  reg [8:0] action_pot;

  assign uio_out [7] = spike_out;
  assign uo_out = action_pot[7:0];

  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      action_pot <= 0;
    end else begin
      action_pot <= (!spike_out)? action_pot + ui_in : 0;
    end
  end
  assign spike_out = (action_pot >= 250);
  // List all unused inputs to prevent warnings
  wire _unused = &{ena, 1'b0};

endmodule



//ui_in      ----> input current/voltage
//uo_out     ----> action potential
//uio_out[7] ----> output spike