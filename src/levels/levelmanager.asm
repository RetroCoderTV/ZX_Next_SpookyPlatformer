GGTILES_SIZE equ 2048

WORLD_WIDTH equ 80
VIEW_WIDTH equ 40
VIEW_HEIGHT equ 32


current_scroll db 0


init_tiles:
    call set_palette

    ;load the tile defs
    nextreg $56, 16
    ld hl,$c000
    ld de,$6000
    ld bc,GGTILES_SIZE
    ldir

    nextreg $6b, %10100000
    nextreg $6c, 0
    nextreg $6e, $40
    nextreg $6f, $60
    nextreg $68, %10000000
    nextreg $43, %00110000

    ld a,4 ;magenta
    nextreg $4c,a ;tilemap transparency colour

    xor a ;black
    nextreg $14,a; global transparency colour
    nextreg $31,a ;tiles y offset
    nextreg $30,a ;tiles x offset
   

    call view_draw

    ret

set_palette:
    ld hl,gg_palette
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



view_draw:
    
    ld hl,level1
    ld de,0x4000
view_draw_line:
    ld bc,VIEW_WIDTH
    ldir
    add hl,WORLD_WIDTH-VIEW_WIDTH
    ld a,d
    cp $60
    ret z
    jp view_draw_line
    


scroll_right:
    ld a,(current_scroll)
    inc a
    ld (current_scroll),a
    nextreg $30,a
    ret



; tiledworld_draw_view:
; 	ld hl,level1
; 	ld de,0x4000
; 	ld bc,WORLD_WIDTH-VIEWPORT_WIDTH
; drawview_start:
; 	push bc
; 	ld bc,VIEWPORT_WIDTH
; 	ldir
; 	pop bc
; 	add hl,bc
; 	ld a,d
; 	cp 0x60
; 	ret z
; 	jp drawview_start








    incbin '../assets/ggtiles.nxp',0



gg_palette:
    incbin '../assets/ggtiles.nxp',0

    MMU 6,16
    org $c000

    incbin '../assets/ggtiles.til',0,GGTILES_SIZE


