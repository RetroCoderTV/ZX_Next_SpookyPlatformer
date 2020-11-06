TILE_DEFINITIONS_SIZE equ 4096

WORLD_WIDTH equ 160
VIEW_WIDTH equ 40
VIEW_HEIGHT equ 32

VIEW_WIDTH_META equ 20


VIEW_SIZE equ VIEW_WIDTH*VIEW_HEIGHT


current_scroll db 0
scroll_direction db RIGHT

LEVEL_START equ 0
; cam_edge_r db LEVEL_START+VIEW_WIDTH_META
cam_x db LEVEL_START

test_layer2_scroll dw 0


layer2_init:
    CLIP_LAYER2 8,151,0,255 ;layer 2 is basically rotated to do 320x256 mode

    nextreg $70, %00010000 ;bit5-4=320x256x8bpp mode
    nextreg $69, %10000000 ;bit7=enable layer2
	nextreg $12,20 ;layer2 ram page register
    ret

tiles_init:
    ; CLIPTILES 8,151,0,255
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
    ld ix,superlevel ;point at level 'map' (in super tiles)
    ld de,$4500 ;
    ld c,0
view_init_screen:
    ld b,VIEW_WIDTH_META
view_init_line_pass1:
    ld hl,supertiles
    ld a,(ix)
    add a,a
    add a,a ;A*4 (supertile size)
    add hl,a
    add hl,a ;add twice to hl because supertile elements are 2 bytes each
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
    ld hl,supertiles
    ld a,(ix)
    add a,a
    add a,a ;A*4 (supertile size)
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


MAX_SCROLL equ 16   

scroll_left:
    ld a,(scroll_direction)
    cp LEFT
    jp z,do_scroll_left

    ld a,LEFT
    ld (scroll_direction),a
do_scroll_left:
    ld a,(cam_x)
    cp 0
    jp z,p_move_left

    ld a,(current_scroll)
    inc a
    cp MAX_SCROLL
    call z,sl_scrollmax
    ld (current_scroll),a
    ld b,a
    ld a,MAX_SCROLL
    sub b
    nextreg $30,a
    ret
sl_scrollmax:
    ld hl,$4a00-4
    ld de,$4a00
    ld bc,20*32*2
    lddr

    ld hl,superlevel
    ld a,(cam_x)
    add hl,a
    ld de,LEVEL_START_ADDRESS
    ld b,LEVEL_HEIGHT_META
    call putsupercolumn

    ld a,(cam_x)
    dec a
    ld (cam_x),a

    xor a
    ld (current_scroll),a

    ret





scroll_right:
    ld a,(scroll_direction)
    cp RIGHT
    jp z,do_scroll_right

    ld a,RIGHT
    ld (scroll_direction),a

do_scroll_right:
    ld a,(cam_x)
    add a,VIEW_WIDTH_META
    cp LEVEL_WIDTH_META
    jp nc, p_move_right

    ld a,(current_scroll)
    inc a
    cp MAX_SCROLL
    ld (current_scroll),a
    call z,sr_scrollmax
    ld a,(current_scroll)
    nextreg $30,a
    ret
sr_scrollmax:
    ld hl,LEVEL_START_ADDRESS+4
    ld de,LEVEL_START_ADDRESS
    ld bc,20*32*2
    ldir
    
    ld hl,superlevel
    ld a,(cam_x)
    add a,VIEW_WIDTH_META
    add hl,a
    ld de,LEVEL_START_ADDRESS+76
    ld b,LEVEL_HEIGHT_META
    call putsupercolumn
    

    ld a,(cam_x)
    inc a
    ld (cam_x),a

    xor a
    ld (current_scroll),a

    ret

putsupercolumn:
    ld a,(hl) ;get supertile id
    add a,a
    add a,a
    push hl ;HL=supertiles again
    ld hl,supertiles
    add hl,a
    add hl,a ;hl=supertiles+=(8*supertile ID)
    ld a,(hl) 
    ld (de),a ;tile Aa
    inc hl
    inc de
    ld a,(hl)
    ld (de),a ;tile Ab
    inc hl
    inc de
    ld a,(hl)
    ld (de),a ;tile Ba
    inc hl
    inc de
    ld a,(hl)
    ld (de),a ;tile Bb
    inc hl
    add de,(VIEW_WIDTH*2)-3 ;down one line of screen tiles (2bytes per tile)
    ld a,(hl)
    ld (de),a ;tile Ca
    inc hl 
    inc de
    ld a,(hl)
    ld (de),a ;tile Cb
    inc hl
    inc de
    ld a,(hl)
    ld (de),a ;tile Da
    inc hl
    inc de
    ld a,(hl)
    ld (de),a ;tile Db
    pop hl
    add de,(VIEW_WIDTH*2)-3
    add hl,LEVEL_WIDTH_META
    djnz putsupercolumn 
    ret









