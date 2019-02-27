VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan3a"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL XLXN_3
        SIGNAL S
        SIGNAL Cout
        SIGNAL XLXN_10
        SIGNAL XLXN_11
        SIGNAL XLXN_14
        SIGNAL XLXN_16
        SIGNAL XLXN_17
        SIGNAL A
        SIGNAL B
        SIGNAL Cin
        SIGNAL XLXN_23
        SIGNAL XLXN_24
        SIGNAL XLXN_25
        PORT Output S
        PORT Output Cout
        PORT Input A
        PORT Input B
        PORT Input Cin
        BEGIN BLOCKDEF xor2
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 0 -64 64 -64 
            LINE N 0 -128 60 -128 
            LINE N 256 -96 208 -96 
            ARC N -40 -152 72 -40 48 -48 44 -144 
            ARC N -24 -152 88 -40 64 -48 64 -144 
            LINE N 128 -144 64 -144 
            LINE N 128 -48 64 -48 
            ARC N 44 -144 220 32 208 -96 128 -144 
            ARC N 44 -224 220 -48 128 -48 208 -96 
        END BLOCKDEF
        BEGIN BLOCKDEF and2
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 0 -64 64 -64 
            LINE N 0 -128 64 -128 
            LINE N 256 -96 192 -96 
            ARC N 96 -144 192 -48 144 -48 144 -144 
            LINE N 144 -48 64 -48 
            LINE N 64 -144 144 -144 
            LINE N 64 -48 64 -144 
        END BLOCKDEF
        BEGIN BLOCKDEF or2
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 0 -64 64 -64 
            LINE N 0 -128 64 -128 
            LINE N 256 -96 192 -96 
            ARC N 28 -224 204 -48 112 -48 192 -96 
            ARC N -40 -152 72 -40 48 -48 48 -144 
            LINE N 112 -144 48 -144 
            ARC N 28 -144 204 32 192 -96 112 -144 
            LINE N 112 -48 48 -48 
        END BLOCKDEF
        BEGIN BLOCK XLXI_1 xor2
            PIN I0 B
            PIN I1 A
            PIN O XLXN_3
        END BLOCK
        BEGIN BLOCK XLXI_2 xor2
            PIN I0 Cin
            PIN I1 XLXN_3
            PIN O S
        END BLOCK
        BEGIN BLOCK XLXI_9 and2
            PIN I0 B
            PIN I1 A
            PIN O XLXN_10
        END BLOCK
        BEGIN BLOCK XLXI_12 and2
            PIN I0 Cin
            PIN I1 XLXN_3
            PIN O XLXN_11
        END BLOCK
        BEGIN BLOCK XLXI_14 or2
            PIN I0 XLXN_11
            PIN I1 XLXN_10
            PIN O Cout
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        INSTANCE XLXI_2 1040 560 R0
        BEGIN BRANCH XLXN_3
            WIRE 896 432 976 432
            WIRE 976 432 976 432
            WIRE 976 432 1040 432
            WIRE 976 432 976 800
            WIRE 976 800 992 800
        END BRANCH
        BEGIN BRANCH S
            WIRE 1296 464 1792 464
        END BRANCH
        IOMARKER 400 400 A R180 28
        IOMARKER 400 464 B R180 28
        IOMARKER 400 560 Cin R180 28
        IOMARKER 1792 464 S R0 28
        BEGIN BRANCH Cout
            WIRE 1568 800 1824 800
        END BRANCH
        IOMARKER 1824 800 Cout R0 28
        BEGIN BRANCH XLXN_11
            WIRE 1248 832 1312 832
        END BRANCH
        INSTANCE XLXI_14 1312 896 R0
        BEGIN BRANCH XLXN_10
            WIRE 896 768 1312 768
        END BRANCH
        INSTANCE XLXI_12 992 928 R0
        BEGIN BRANCH A
            WIRE 400 400 544 400
            WIRE 544 400 544 736
            WIRE 544 736 640 736
            WIRE 544 400 640 400
        END BRANCH
        BEGIN BRANCH Cin
            WIRE 400 560 720 560
            WIRE 720 496 720 560
            WIRE 720 496 912 496
            WIRE 912 496 1040 496
            WIRE 912 496 912 864
            WIRE 912 864 992 864
        END BRANCH
        INSTANCE XLXI_9 640 864 R0
        BEGIN BRANCH B
            WIRE 400 464 496 464
            WIRE 496 464 496 800
            WIRE 496 800 640 800
            WIRE 496 464 640 464
        END BRANCH
        INSTANCE XLXI_1 640 528 R0
    END SHEET
END SCHEMATIC
