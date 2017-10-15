; ALLOWS ONE TO START THE APPLICATION WITH RUN
; SYS 2064
*=$0801 
         BYTE $0C, $8, $0A, $00, $9E, $20, $32, $30, $36, $34, $00, $00, $00, $00, $00


CLEAR           = $E544


SPR_ENABLE      = $D015 ; FLAGS FOR SPRITE ENABLING
SPR_MSBX        = $D010 ; FLAGS TO REPRESENT X VALUES LARGER THAN 255
SPR_COLORMODE   = $D01C ; FLAGS TO SET COLOR MODES (0 = HIGH RES/2-COLOR, 1 = MULTICOLOR/4-COLOR)
SPR_COLOR0      = $D025 ; SHARED SPRITE COLOR 0
SPR_COLOR1      = $D026 ; SHARED SPRITE COLOR 1

SPR0_PTR        = $07F8 ; SPRITE 0 DATA POINTER
SPR0_X          = $D000 ; SPRITE X COORDINATE
SPR0_Y          = $D001 ; SPRITE Y COORDINATE
SPR0_COLOR      = $D027 ; SPRITE 0 COLOR

FRAME0_ADDR     = #$80
FRAME0_DATA     = $2000    

COLOR_BLACK             = #0
COLOR_LIGHT_GRAY        = #15


INIT    JSR CLEAR

        ; ENABLE SPRITES
        LDA #%00000001
        STA SPR_ENABLE

        ; SET COLOR MODES
        LDA #%00000001
        STA SPR_COLORMODE

        ; SET SPRITE COLORS
        LDA COLOR_BLACK
        STA SPR0_COLOR
        LDA COLOR_LIGHT_GRAY
        STA SPR_COLOR0

        ; SET SPRITE X = 0*255 + 100
        LDX #%00000000
        STX SPR_MSBX
        LDX #100
        STX SPR0_X

        ; SET SPRITE Y = 100
        LDY #100
        STY SPR0_Y

        ; SET SPRITE POINTER
        LDA FRAME0_ADDR
        STA SPR0_PTR

        ; LOAD SPRITE FRAMES IN A LOOP
        LDX #0
LOAD    LDA SPRITES,X
        STA FRAME0_DATA,X
        INX
        CPX #255
        BNE LOAD

       
LOOP    
        LDX #255
        LDY #50

WAIT    DEX
        BNE WAIT
        DEY
        BNE WAIT

        ; GET CURRENT FRAME POINTER
        LDX SPR0_PTR
        CPX #$83
        BNE NEXT

FIRST   LDX FRAME0_ADDR
        STX SPR0_PTR
        JMP LOOP

NEXT    INX
        STX SPR0_PTR
        JMP LOOP

SPRITES BYTE 0,168,0 ;FRAME 0
        BYTE 0,168,0
        BYTE 0,168,0
        BYTE 0,168,0
        BYTE 0,168,0
        BYTE 0,0,0
        BYTE 0,0,0
        BYTE 84,0,84
        BYTE 84,0,84
        BYTE 84,0,84
        BYTE 84,0,84
        BYTE 84,0,84
        BYTE 0,0,0
        BYTE 0,0,0
        BYTE 0,84,0
        BYTE 0,84,0
        BYTE 0,84,0
        BYTE 0,84,0
        BYTE 0,84,0
        BYTE 0,0,0
        BYTE 0,0,0
        BYTE 0

        BYTE 0,84,0 ;FRAME 1
        BYTE 0,84,0
        BYTE 0,84,0
        BYTE 0,84,0
        BYTE 0,84,0
        BYTE 0,0,0
        BYTE 0,0,0
        BYTE 84,0,168
        BYTE 84,0,168
        BYTE 84,0,168
        BYTE 84,0,168
        BYTE 84,0,168
        BYTE 0,0,0
        BYTE 0,0,0
        BYTE 0,84,0
        BYTE 0,84,0
        BYTE 0,84,0
        BYTE 0,84,0
        BYTE 0,84,0
        BYTE 0,0,0
        BYTE 0,0,0
        BYTE 0

        BYTE 0,84,0 ;FRAME 2
        BYTE 0,84,0
        BYTE 0,84,0
        BYTE 0,84,0
        BYTE 0,84,0
        BYTE 0,0,0
        BYTE 0,0,0
        BYTE 84,0,84
        BYTE 84,0,84
        BYTE 84,0,84
        BYTE 84,0,84
        BYTE 84,0,84
        BYTE 0,0,0
        BYTE 0,0,0
        BYTE 0,168,0
        BYTE 0,168,0
        BYTE 0,168,0
        BYTE 0,168,0
        BYTE 0,168,0
        BYTE 0,0,0
        BYTE 0,0,0
        BYTE 0

        BYTE 0,84,0 ;FRAME 3
        BYTE 0,84,0
        BYTE 0,84,0
        BYTE 0,84,0
        BYTE 0,84,0
        BYTE 0,0,0
        BYTE 0,0,0
        BYTE 168,0,84
        BYTE 168,0,84
        BYTE 168,0,84
        BYTE 168,0,84
        BYTE 168,0,84
        BYTE 0,0,0
        BYTE 0,0,0
        BYTE 0,84,0
        BYTE 0,84,0
        BYTE 0,84,0
        BYTE 0,84,0
        BYTE 0,84,0
        BYTE 0,0,0
        BYTE 0,0,0
        BYTE 0
