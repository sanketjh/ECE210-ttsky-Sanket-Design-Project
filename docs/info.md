<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This code implements an integrate-and-fire neuron. It takes an 8-bit input, which is accumulated onto an action potential. The action potential is implemented using 9 bits internally to handle overflows. The module outputs the 8 LSB bits of this action potential and an output spike (whenever the action potential exceeds 250).

## How to test

Make rst_n low to drive the circuit to a known state initially. Make rst_n high again. Give a clock (clk) and some input voltage (ui_in). Keep track of the actual and expected action potential (uo_out) and the output spikes (uio_out[7]).
