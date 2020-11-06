TILE_DEFINITIONS_SIZE equ 4096

WORLD_WIDTH equ 160
VIEW_WIDTH equ 40
VIEW_HEIGHT equ 32

VIEW_WIDTH_META equ 20


VIEW_SIZE equ VIEW_WIDTH*VIEW_HEIGHT


current_scroll db 0
scroll_direction db RIGHT

LEVEL_START equ 0
cam_edge_r db LEVEL_START+VIEW_WIDTH_META
cam_x db LEVEL_START

test_layer2_scroll dw 0


layer2_init:
    CLIP_LAYER2 4,155,0,255 ;layer 2 is basically rotated to do 320x256 mode

    nextreg $70, %00010000 ;bit5-4=320x256x8bpp mode
    nextreg $69, %10000000 ;bit7=enable layer2
	nextreg $12,20 ;layer2 ram page register
    ret

tiles_init:
    ; CLIPTILES 4,155,0,255
    call tiles_set_palette

    ;load the tile defs
    nextreg $56, 16
    ld hl,$c000
    ld de,$6000
    ld bc,TILE_DEFINITIONS_SIZE
    ldir

    nextreg $6b, %10000000
    nextreg $6c, 0
    nextreg $6e, $40
    nextreg $6f, $60
    nextreg $68, %10000000
    nextreg $43, %00110000

    ; ld a,3
    
    xor a ;black
    nextreg $4c,a ;tilemap transparency colour 
    nextreg $14,a; global transparency colour

   

    call view_init

    ret


layer2_update:
    ld hl,(test_layer2_scroll)
    ld a,l
    nextreg $16, a
    ld a,h
    nextreg $71, a
    inc hl
    inc hl

    ld (test_layer2_scroll),hl
    cp 0
    ret z

    ld a,l
    cp low 320 ;sjasm - gives the low byte needed for value 320
    ret nz

    ld hl,0
    ld (test_layer2_scroll),hl

    ret 




tiles_set_palette:
    ld hl,caveman_palette
    nextreg $43,%00110000
    xor a
    ld b,16
    nextreg $40,a
uploadpal:
    ld a,(hl)
    nextreg $44,a
    inc hl
    ld a,(hl)
    nextreg $44,a
    inc hl
    djnz uploadpal
    ret


;does 2 passes per 'map' line, due to 2 rows within each supertile
view_init:
    ld ix,metalevel ;point at level 'map' (in meta tiles)
    ld de,$4500 ;
    ld c,0
view_init_screen:
    ld b,VIEW_WIDTH_META
view_init_line_pass1:
    ld hl,metatiles
    ld a,(ix)
    add a,a
    add a,a ;A*4 (metatile size)
    add hl,a
    add hl,a ;add twice to hl because metatile elements are 2 bytes each
    ld a,(hl)
    ld (de),a
    inc hl
    inc de
    ld a,(hl)
    ld (de),a
    inc hl
    inc de
    ld a,(hl)
    ld (de),a
    inc hl
    inc de
    ld a,(hl)
    ld (de),a
    inc de
    inc ix
    djnz view_init_line_pass1
    ld b,VIEW_WIDTH_META
view_init_golineback:
    dec ix
    djnz view_init_golineback
    ld b,VIEW_WIDTH_META
view_init_line_pass2:
    ld hl,metatiles
    ld a,(ix)
    add a,a
    add a,a ;A*4 (metatile size)
    add hl,a
    add hl,a
    ld a,4
    add hl,a
    ld a,(hl)
    ld (de),a
    inc hl
    inc de
    ld a,(hl)
    ld (de),a
    inc hl
    inc de
    ld a,(hl)
    ld (de),a
    inc hl
    inc de
    ld a,(hl)
    ld (de),a
    inc de
    inc ix
    djnz view_init_line_pass2

    push de
    ld de,LEVEL_WIDTH_META-VIEW_WIDTH_META
    add ix,de
    pop de
    inc c
    ld a,c
    cp LEVEL_HEIGHT_META
    jp c,view_init_screen
    ret


current_meta_column db 0      

;OO     OO
;OO     OO
scroll_left:
    ld a,(cam_edge_r)
    sub VIEW_WIDTH_META
    ld (cam_x),a

    ld a,(scroll_direction)
    cp LEFT
    jp z,do_scroll_left
    
    ld a,LEFT
    ld (scroll_direction),a

    ld a,(current_meta_column)
    ld b,a
    ld a,(cam_edge_r)
    sub b
    ld (cam_edge_r),a
    sub VIEW_WIDTH_META
    ld (cam_x),a


do_scroll_left:
    ld a,(cam_edge_r)
    sub VIEW_WIDTH_META
    jp z,p_move_left

    ld a,(current_scroll)
    inc a
    cp 8          
    call z,sl_scrollmax 
    ld (current_scroll),a
    ld b,a
    ld a,8
    sub b
    nextreg $30,a
    ret
sl_scrollmax:
    ld hl,$4a00-2
    ld de,$4a00
    ld bc,20*32*2
    lddr  

    ld hl,metalevel            
    ld a,(cam_x)     
    add hl,a                                  
    ld de,LEVEL_Y_START_ADDRESS             ; top left cell 
    ld b,LEVEL_HEIGHT_META

    ld a,(current_meta_column)
    cp 0
    jp z,sl_putcolumn1
    jp nz,sl_putcolumn2

sl_putcolumn1:
    ld a,(hl)
    add a,a
    add a,a
    push hl
    ld hl,metatiles
    add hl,a
    add hl,a
    ld a,(hl) 
    ld (de),a 
    inc hl
    inc de
    ld a,(hl)
    ld (de),a   
    pop hl
    add de,(VIEW_WIDTH*2)-1 ;WIDTH-1
    ld a,(hl)
    add a,a
    add a,a
    push hl
    ld hl,metatiles
    add hl,a
    add a,4
    add hl,a
    ld a,(hl)
    ld (de),a 
    inc hl
    inc de
    ld a,(hl)
    ld (de),a  
    pop hl
    add de,(VIEW_WIDTH*2)-1
    add hl,LEVEL_WIDTH_META
    djnz sl_putcolumn1
    
    ld a,1
    ld (current_meta_column),a

    xor a
    ld (current_scroll),a

    ret
sl_putcolumn2:
    ld a,(hl)
    add a,a
    add a,a
    push hl
    ld hl,metatiles
    add hl,a
    add a,2
    add hl,a
    ld a,(hl)
    ld (de),a ;Ba
    inc hl
    inc de
    ld a,(hl)
    ld (de),a ;Bb   
    pop hl
    add de,(VIEW_WIDTH*2)-1 ;WIDTH-1
    ld a,(hl)
    add a,a
    add a,a
    push hl
    ld hl,metatiles
    add hl,a
    add a,6
    add hl,a
    ld a,(hl)
    ld (de),a ;Da
    inc hl
    inc de
    ld a,(hl)
    ld (de),a ;Db   
    pop hl
    add de,(VIEW_WIDTH*2)-1
    add hl,LEVEL_WIDTH_META
    djnz sl_putcolumn2
    
   
    ld a,0
    ld (current_meta_column),a


    ld a,(cam_edge_r)
    dec a
    ld (cam_edge_r),a

    xor a
    ld (current_scroll),a

    ret

   


scroll_right:
    ld a,(cam_edge_r)
    sub VIEW_WIDTH_META
    ld (cam_x),a
    
    ld a,(scroll_direction)
    cp RIGHT
    jp z,do_scroll_right
    
    ld a,RIGHT
    ld (scroll_direction),a

do_scroll_right:

    

    ld a,(cam_edge_r)
    cp LEVEL_WIDTH_META
    jp nc, p_move_right

    ld a,(current_scroll)
    inc a
    cp 8
    ld (current_scroll),a
    call z,sr_scrollmax
    ld a,(current_scroll)
    nextreg $30,a
    ret
sr_scrollmax:
    ld hl,LEVEL_Y_START_ADDRESS+2
    ld de,LEVEL_Y_START_ADDRESS
    ld bc,20*32*2
    ldir

    ld hl,metalevel
    ld a,(cam_edge_r)
    add hl,a
    ld de,LEVEL_Y_START_ADDRESS+78
    ld b,LEVEL_HEIGHT_META

    ld a,(current_meta_column)
    cp 0 
    jp z,sr_putcolumn1
    jp nz,sr_putcolumn2
sr_putcolumn1:
    ld a,(hl)
    add a,a
    add a,a
    push hl
    ld hl,metatiles
    add hl,a
    add hl,a
    ld a,(hl) 
    ld (de),a 
    inc hl
    inc de
    ld a,(hl)
    ld (de),a   
    pop hl
    add de,(VIEW_WIDTH*2)-1 ;WIDTH-1
    ld a,(hl)
    add a,a
    add a,a
    push hl
    ld hl,metatiles
    add hl,a
    add a,4
    add hl,a
    ld a,(hl)
    ld (de),a 
    inc hl
    inc de
    ld a,(hl)
    ld (de),a  
    pop hl
    add de,(VIEW_WIDTH*2)-1
    add hl,LEVEL_WIDTH_META
    djnz sr_putcolumn1
    
    ld a,1
    ld (current_meta_column),a

    xor a
    ld (current_scroll),a

    ret
sr_putcolumn2:
    ld a,(hl)
    add a,a
    add a,a
    push hl
    ld hl,metatiles
    add hl,a
    add a,2
    add hl,a
    ld a,(hl)
    ld (de),a ;Ba
    inc hl
    inc de
    ld a,(hl)
    ld (de),a ;Bb   
    pop hl
    add de,(VIEW_WIDTH*2)-1 ;WIDTH-1
    ld a,(hl)
    add a,a
    add a,a
    push hl
    ld hl,metatiles
    add hl,a
    add a,6
    add hl,a
    ld a,(hl)
    ld (de),a ;Da
    inc hl
    inc de
    ld a,(hl)
    ld (de),a ;Db   
    pop hl
    add de,(VIEW_WIDTH*2)-1
    add hl,LEVEL_WIDTH_META
    djnz sr_putcolumn2
    
   
    ld a,0
    ld (current_meta_column),a


    ld a,(cam_edge_r)
    inc a
    ld (cam_edge_r),a

    xor a
    ld (current_scroll),a

    ret











; scroll_right_old:
;     ld a,RIGHT
;     ld (scroll_direction),a

;     ld a,(cam_edge_r)
;     sub VIEW_WIDTH_META
;     ld (cam_x),a

;     ld a,(cam_edge_r)
;     cp LEVEL_WIDTH_META
;     jp nc, p_move_right

;     ld a,(current_scroll)
;     inc a
;     cp 8
;     ld (current_scroll),a
;     call z,sr_scrollmax
;     ld (current_scroll),a
;     nextreg $30,a
;     ret
; sr_scrollmax:
;     ld hl,LEVEL_Y_START_ADDRESS+1
;     ld de,LEVEL_Y_START_ADDRESS
;     ld bc,20*32
;     ldir
;     ld hl,metalevel
;     ld a,(cam_edge_r)
;     add hl,a
;     ld de,LEVEL_Y_START_ADDRESS+39 ;top right cell
;     ld b,LEVEL_HEIGHT_META
    
;     ld a,(current_meta_column)
;     cp 0
;     jp z,sr_putcolumn
;     jp nz,sr_putcolumn_2nd
; sr_putcolumn:
;     ld a,(hl)
;     add a,a
;     add a,a ;A*4
;     push hl
;     ld hl,metatiles
;     add hl,a
;     add hl,a
;     ld a,(hl)
;     ld (de),a
;     inc hl
;     inc de
;     ld a,(hl)
;     pop hl
;     ld (de),a
;     add de,VIEW_WIDTH-1
;     ld a,(hl)
;     add a,a
;     add a,a ;A*4
;     push hl
;     ld hl,metatiles
;     add hl,a
;     add a,4 ; halfway thru the metatile
;     add hl,a
;     ld a,(hl)
;     ld (de),a
;     inc hl
;     inc de
;     ld a,(hl)
;     pop hl
;     ld (de),a
;     add de,VIEW_WIDTH-1
;     add hl,LEVEL_WIDTH_META
;     djnz sr_putcolumn
    
;     ld a,1
;     ld (current_meta_column),a

;     xor a
;     ld (current_scroll),a

;     ret
; sr_putcolumn_2nd:
;    ld a,(hl)
;     add a,a
;     add a,a ;A*4
;     push hl
;     ld hl,metatiles
;     add hl,a
;     add a,2
;     add hl,a
;     ld a,(hl)
;     ld (de),a
;     inc hl
;     inc de
;     ld a,(hl)
;     pop hl
;     ld (de),a
;     add de,VIEW_WIDTH-1
;     ld a,(hl)
;     add a,a
;     add a,a ;A*4
;     push hl
;     ld hl,metatiles
;     add hl,a
;     add a,6 ; halfway thru the metatile
;     add hl,a
;     ld a,(hl)
;     ld (de),a
;     inc hl
;     inc de
;     ld a,(hl)
;     pop hl
;     ld (de),a
;     add de,VIEW_WIDTH-1
;     add hl,LEVEL_WIDTH_META
;     djnz sr_putcolumn_2nd

    
;     ld a,(cam_edge_r)
;     inc a
;     ld (cam_edge_r),a
    
;     ld a,0
;     ld (current_meta_column),a

;     xor a
;     ld (current_scroll),a

;     ret







; scroll_left:
;     ld a,LEFT
;     ld (scroll_direction),a

;     ld a,(cam_edge_r)
;     cp LEVEL_START+VIEW_WIDTH+1
;     jp c, p_move_left

;     ld a,(cam_edge_r)
;     sub VIEW_WIDTH
;     ld (cam_x),a

;     ld a,(current_scroll)
;     inc a
;     cp 8          
;     call z,sl_scrollmax 
;     ld (current_scroll),a
;     ld b,a
;     ld a,8
;     sub b
;     nextreg $30,a
;     ret
; sl_scrollmax:
;     ; ld hl,$4000+1279
;     ; ld de,$4001+1279
;     ld hl,$44FF
;     ld de,$4500
;     ld bc,40*32
;     lddr  ; move whole screen to right 1 tile 
;     ld hl,level1            ; start of tiles 
;     ld a,(cam_x)           ; current cam_edge_r 
;     dec a
;     add hl,a                ; add this to tile cam_edge_r 
;     ; dec a                   ; dec the cam_edge_r 
;     add a,VIEW_WIDTH
;     ld (cam_edge_r),a
;     ld de,$4000              ; top left cell 
;     ld b,VIEW_HEIGHT
; columnloop_left:
;     ld a,(hl)                   ; get tile from (hl)
;     ld (de),a                   ; put in (de)
;     add de,VIEW_WIDTH                  ; move de to next line
;     add hl,WORLD_WIDTH          ; move hl to next map line
;     djnz columnloop_left             ; loop for 32 lines 
;     xor a
;     ld (current_scroll),a
;     ret 



; scroll_right:
;     ld a,RIGHT
;     ld (scroll_direction),a

;     ld a,(cam_edge_r)
;     cp WORLD_WIDTH
;     jp nc, p_move_right
;     ld a,(current_scroll)
;     inc a
;     cp 8            
;     call z,nowdrawcolumn 
;     ld (current_scroll),a
;     nextreg $30,a
;     ret
; nowdrawcolumn:
;     ld hl,$4001
;     ld de,$4000
;     ld bc,1280
;     ldir  ; move whole screen to left 1 tile 
;     ld hl,level1            ; start of tiles 
;     ld a,(cam_edge_r)           ; current cam_edge_r 
;     add hl,a                ; add this to tile cam_edge_r 
;     inc a                   ; inc the cam_edge_r 
;     ld (cam_edge_r),a
;     ld de,$4027              ; top right cell 
;     ld b,VIEW_HEIGHT
; columnloop:
;     ld a,(hl)                   ; get tile from (hl)
;     ld (de),a                   ; put in (de)
;     add de,VIEW_WIDTH                  ; move de to next line
;     add hl,WORLD_WIDTH          ; move hl to next map line
;     djnz columnloop             ; loop for 32 lines 
;     xor a
;     ld (current_scroll),a
;     ret 












