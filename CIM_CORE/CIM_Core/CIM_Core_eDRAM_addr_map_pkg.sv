package CIM_Core_eDRAM_addr_map;

typedef enum int unsigned { 
    eDRAM_0     = 0,
    eDRAM_1     = 1,
    eDRAM_2     = 2,
    eDRAM_3     = 3,
    eDRAM_4     = 4,
    eDRAM_5     = 5,
    eDRAM_6     = 6,
    eDRAM_7     = 7,
    eDRAM_8     = 8,
    eDRAM_9     = 9,
    eDRAM_10     = 10,
    eDRAM_11     = 11,
    eDRAM_12     = 12,
    eDRAM_13     = 13,
    eDRAM_14     = 14,
    eDRAM_15     = 15
} CIM_Core_eDRAM_slaves_t;

localparam NB_eDRAMS = eDRAM_15 + 1;

localparam logic [63:0] eDRAM_0Length     = 64'h80_0000;
localparam logic [63:0] eDRAM_1Length     = 64'h80_0000;
localparam logic [63:0] eDRAM_2Length     = 64'h80_0000;
localparam logic [63:0] eDRAM_3Length     = 64'h80_0000;
localparam logic [63:0] eDRAM_4Length     = 64'h80_0000;
localparam logic [63:0] eDRAM_5Length     = 64'h80_0000;
localparam logic [63:0] eDRAM_6Length     = 64'h80_0000;
localparam logic [63:0] eDRAM_7Length     = 64'h80_0000;
localparam logic [63:0] eDRAM_8Length     = 64'h80_0000;
localparam logic [63:0] eDRAM_9Length     = 64'h80_0000;
localparam logic [63:0] eDRAM_10Length     = 64'h80_0000;
localparam logic [63:0] eDRAM_11Length     = 64'h80_0000;
localparam logic [63:0] eDRAM_12Length     = 64'h80_0000;
localparam logic [63:0] eDRAM_13Length     = 64'h80_0000;
localparam logic [63:0] eDRAM_14Length     = 64'h80_0000;
localparam logic [63:0] eDRAM_15Length     = 64'h80_0000;


typedef enum logic [63:0] {
    eDRAM_0Base     = 64'h5000_0000,
    eDRAM_1Base     = 64'h5080_0000,
    eDRAM_2Base     = 64'h5100_0000,
    eDRAM_3Base     = 64'h5180_0000,
    eDRAM_4Base     = 64'h5200_0000,
    eDRAM_5Base     = 64'h5280_0000,
    eDRAM_6Base     = 64'h5300_0000,
    eDRAM_7Base     = 64'h5380_0000,
    eDRAM_8Base     = 64'h5400_0000,
    eDRAM_9Base     = 64'h5480_0000,
    eDRAM_10Base     = 64'h5500_0000,
    eDRAM_11Base     = 64'h5580_0000,
    eDRAM_12Base     = 64'h5600_0000,
    eDRAM_13Base     = 64'h5680_0000,
    eDRAM_14Base     = 64'h5700_0000,
    eDRAM_15Base     = 64'h5780_0000
} CIM_Core_eDRAM_start_t;

endpackage