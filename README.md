### TestBench

tb/tb_top.sv

### System Top

corev_apu/fpga/src/ariane_xilinx.sv

### FPGA Simulation

!!! Change the COE file directory in `corev_apu/fpga/xilinx/xlnx_bram_128x64/tcl/run.tcl`, must use absolute directory!

```
make fpga
```

This `make` will synthesize the whole SoC using Vivado 2018.02.
After synthesize finish, run Vivado 18.02 GUI.
In the GUI, run `source corev_apu/fpga/scripts/add_wave.tcl` in the bottom TCL Console.
This will run the post-synthesis simulation and add some waves to the waveform viewer.