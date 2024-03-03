// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Author: Florian Zaruba, ETH Zurich
// Description: Contains SoC information as constants
package ariane_soc;
  // M-Mode Hart, S-Mode Hart
  localparam int unsigned NumTargets = 2;
  // Uart, SPI, Ethernet, reserved
  localparam int unsigned NumSources = 30;
  localparam int unsigned MaxPriority = 7;

  localparam NrSlaves = 2; // actually masters, but slaves on the crossbar

  typedef enum int unsigned {
    Main_Mem              = 0,
    CIM_Core_regbus       = 1,
    CIM_Core_sram         = 2,
    CIM_Core_macro        = 3,
    CIM_Core_eDRAM        = 4,
    Top_Ctrl              = 5,
    Timer                 = 6,
    UART                  = 7,
    PLIC                  = 8,
    CLINT                 = 9,
    ROM                   = 10,
    Debug                 = 11
  } axi_slaves_t;

  localparam NB_PERIPHERALS = Debug + 1;


  localparam logic[63:0] DebugLength            = 64'h1000;
  localparam logic[63:0] ROMLength              = 64'h10000;
  localparam logic[63:0] CLINTLength            = 64'hC0000;
  localparam logic[63:0] PLICLength             = 64'h3FF_FFFF;
  localparam logic[63:0] UARTLength             = 64'h1000;
  localparam logic[63:0] TimerLength            = 64'h1000;
  //////
  localparam logic[63:0] CIM_Core_regbusLength  = 64'h8000000;
  localparam logic[63:0] CIM_Core_sramLength    = 64'h8000000;
  localparam logic[63:0] CIM_Core_macroLength   = 64'h20000000;
  localparam logic[63:0] CIM_Core_eDRAMLength   = 64'h20000000;
  localparam logic[63:0] Top_CtrlLength         = 64'h8000000;
  //////
  localparam logic[63:0] Main_MemLength        = 64'h40000000;  // 24 MByte of SRAM
  // Instantiate AXI protocol checkers
  localparam bit GenProtocolChecker = 1'b0;

  typedef enum logic [63:0] {
    DebugBase             = 64'h0000_0000,
    ROMBase               = 64'h0001_0000,
    CLINTBase             = 64'h0200_0000,
    PLICBase              = 64'h0C00_0000,
    UARTBase              = 64'h1000_0000,
    TimerBase             = 64'h1800_0000,
    CIM_Core_regbusBase   = 64'h2000_0000,
    CIM_Core_sramBase     = 64'h2800_0000,
    CIM_Core_macroBase    = 64'h3000_0000,
    CIM_Core_eDRAMBase    = 64'h5000_0000,
    Top_CtrlBase          = 64'h7000_0000,
    Main_MemBase          = 64'h8000_0000
  } soc_bus_start_t;

  localparam NrRegion = 1;
  localparam logic [NrRegion-1:0][NB_PERIPHERALS-1:0] ValidRule = {{NrRegion * NB_PERIPHERALS}{1'b1}};

endpackage
