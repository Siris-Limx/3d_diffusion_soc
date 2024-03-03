package CIM_Core_macro_addr_map;

typedef enum int unsigned { 
    macro_0     = 0,
    macro_1     = 1,
    macro_2     = 2,
    macro_3     = 3,
    macro_4     = 4,
    macro_5     = 5,
    macro_6     = 6,
    macro_7     = 7,
    macro_8     = 8
} CIM_Core_macro_slaves_t;

localparam NB_MACROS = macro_8 + 1;

localparam logic [63:0] macro_0Length     = 64'h80_0000;
localparam logic [63:0] macro_1Length     = 64'h80_0000;
localparam logic [63:0] macro_2Length     = 64'h80_0000;
localparam logic [63:0] macro_3Length     = 64'h80_0000;
localparam logic [63:0] macro_4Length     = 64'h80_0000;
localparam logic [63:0] macro_5Length     = 64'h80_0000;
localparam logic [63:0] macro_6Length     = 64'h80_0000;
localparam logic [63:0] macro_7Length     = 64'h80_0000;
localparam logic [63:0] macro_8Length     = 64'h80_0000;


typedef enum logic [63:0] {
    macro_0Base     = 64'h3000_0000,
    macro_1Base     = 64'h3080_0000,
    macro_2Base     = 64'h3100_0000,
    macro_3Base     = 64'h3180_0000,
    macro_4Base     = 64'h3200_0000,
    macro_5Base     = 64'h3280_0000,
    macro_6Base     = 64'h3300_0000,
    macro_7Base     = 64'h3380_0000,
    macro_8Base     = 64'h3400_0000
} CIM_Core_macro_start_t;

endpackage