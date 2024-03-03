package CIM_Core_addr_map;

typedef enum int unsigned { 
    Reg_file = 0,
    SRAM     = 1,
    Macro    = 2,
    eDRAM    = 3
} axi_CIM_Core_slaves_t;

localparam NB_CIM_CORE_COMPONENTS = eDRAM + 1;

localparam logic [63:0] Reg_fileLength    = 64'h800_0000;
localparam logic [63:0] SRAMLength        = 64'h800_0000;
localparam logic [63:0] MacroLength       = 64'h2000_0000;
localparam logic [63:0] eDRAMLength       = 64'h2000_0000;

typedef enum logic [63:0] {
    Reg_fileBase    = 64'h2000_0000,
    SRAMBase        = 64'h2800_0000,
    MacroBase       = 64'h3000_0000,
    eDRAMBase       = 64'h5000_0000
} CIM_Core_bus_start_t;

endpackage