PLAYER_SLOT equ 50

PLAYER_DEFAULT_ATTR3 equ %11000000

PLAYER_HEIGHT equ 32

SCROLL_MARKER_X equ 320/2

PLAYER_WALK_SPEED equ 1

px dw 50
py db 190
player_attr_2 db %00001000
player_attr_3 db PLAYER_DEFAULT_ATTR3
player_attr_4 db %00100000

player_animation_timer db 0
PLAYER_ANIMATION_DELAY equ 4




player_init:
    call player_init_sprites
    ret

player_init_sprites:
    ld a,PLAYER_SLOT
    nextreg $34,a

    ;attr 0
    ld a,(px)
    nextreg $35,a

    ;attr 1
    ld a,(py)
    nextreg $36,a

    ;attr 2
    ld a,(player_attr_2)
    ld b,a
    ld hl,(px)
    ld a,h
    or b
    nextreg $37,a

    ;attr 3
    ld a,(player_attr_3)
    nextreg $38,a

    ;attr 4
    ld a,(player_attr_4)
    nextreg $39,a

    ;relative sprites...

    ;r1:
    ;x0
    ;xx

    ld a,PLAYER_SLOT+1
    nextreg $34,a

    ;a0
    ld a,16
    nextreg $35,a

    ;a1
    ld a,0
    nextreg $36,a

    ;a2
    ld a,%00000001
    nextreg $37,a

    ;a3
    ld a,%11000001
    nextreg $38,a

    ;a4
    ld a,%01000001
    nextreg $39,a

    ;r2:
    ;xx
    ;0x
    ld a,PLAYER_SLOT+2
    nextreg $34,a
    
    ;a0
    ld a,0
    nextreg $35,a

    ;a1
    ld a,16
    nextreg $36,a

    ;a2
    ld a,%00000001
    nextreg $37,a

    ;a3
    ld a,%11000010
    nextreg $38,a

    ;a4
    ld a,%01000001
    nextreg $39,a

    ;r3:
    ;xx
    ;x0
    ld a,PLAYER_SLOT+3
    nextreg $34,a
    
    ;a0
    ld a,16
    nextreg $35,a

    ;a1
    ld a,16
    nextreg $36,a

    ;a2
    ld a,%00000001
    nextreg $37,a

    ;a3
    ld a,%11000011
    nextreg $38,a

    ;a4
    ld a,%01000001
    nextreg $39,a

    ret 
;



player_update:
    ld a,(player_animation_timer)
    inc a
    ld (player_animation_timer),a

    ld a,(keypressed_D)
    cp TRUE
    call z,plyr_move_right


    ret



plyr_move_right:
    ld a,(player_animation_timer)
    cp PLAYER_ANIMATION_DELAY
    call nc, player_animate_walk

    ld hl,(px)
    ld a,l
    cp SCROLL_MARKER_X
    jp nc,scroll_right
    jp c,p_move_right
        
p_move_right
    add hl,PLAYER_WALK_SPEED
    ld (px),hl
    ret







player_draw:
    ld a,PLAYER_SLOT
    nextreg $34,a

    ;attr 0
    ld a,(px)
    nextreg $35,a

    ;attr 1
    ld a,(py)
    nextreg $36,a

    ;attr 2
    ld a,(player_attr_2)
    ld b,a
    ld hl,(px)
    ld a,h
    or b
    nextreg $37,a

    ;attr 3
    ld a,(player_attr_3)
    nextreg $38,a

    ;attr 4
    ld a,(player_attr_4)
    nextreg $39,a

    ret 




player_animate_walk:
    xor a
    ld (player_animation_timer),a
    
    ld a,(player_attr_3)
    and %00111111 ;mask out top 2 bits
    cp SPRITE_COUNT-SPRITE_SEGMENTS
    jp z,player_set_to_default_frame
    add a,SPRITE_SEGMENTS
    add a,PLAYER_DEFAULT_ATTR3
    ld (player_attr_3),a
    ret

player_set_to_default_frame:
    ld a,PLAYER_DEFAULT_ATTR3
    ld (player_attr_3),a
    ret



    
