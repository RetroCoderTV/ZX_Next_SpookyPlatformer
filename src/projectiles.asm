

;0=wX
;1=wY
;2,3=xx
;4=y
;5=attr2
;6=attr3
;7=slot_ID

projectiles:
    db OUT_OF_WORLD,0 : dw 0 : db 0, %00000000, %00100100, 20
    db OUT_OF_WORLD,0 : dw 0 : db 0, %00000000, %00100100, 21
    db OUT_OF_WORLD,0 : dw 0 : db 0, %00000000, %00100100, 22
    db END_OF_ARRAY
PROJECTILES_DATA_LENGTH equ 8


projectiles_init:
    
    ret







projectiles_spawn:
    ld ix,projectiles
proj_spwn_start:
    ld a,(ix)
    cp END_OF_ARRAY
    ret z

    ld a,(ix+6)
    bit 7,a
    jp nz,proj_spwn_next

    set 7,a
    ld (ix+6),a


    ld a,(player_world_x) 
    ld (ix),a

    ld hl,(px)
    ld (ix+2),l
    ld (ix+3),h

    

    xor a ;py offset
    ld (ix+4),a

    ld a,(player_world_y)
    ld (ix+1),a


    ret
proj_spwn_next:
    ld de,PROJECTILES_DATA_LENGTH
    add ix,de
    jp proj_spwn_start



projectiles_update:
    ld ix,projectiles
proj_upd_start:
    ld a,(ix)
    cp END_OF_ARRAY
    ret z

    call projectile_update

proj_upd_next:
    ld de,PROJECTILES_DATA_LENGTH
    add ix,de
    jp proj_upd_start



projectiles_draw:
    ld ix,projectiles
proj_drw_start:
    ld a,(ix)
    cp END_OF_ARRAY
    ret z

    ld a,(ix+6)
    bit 7,a
    jp z,proj_drw_next

    call projectile_draw

proj_drw_next:
    ld de,PROJECTILES_DATA_LENGTH
    add ix,de
    jp proj_drw_start





projectile_update:
    call projectile_check_in_view
    call projectile_calculate_screen_pos
    
    ld a,(ix+6)
    bit 7,a
    ret z
    
    ;move projectile up
    ld a,(ix+4)
    inc a
    inc a
    inc a
    inc a
    ld (ix+4),a
    cp MAX_SCROLL
    call z,proj_up_one
    
    


    ld a,(frame_counter)
    and %00000011
    call z,projectile_rotate

    ret

proj_up_one:
    ld a,(ix+1)
    dec a
    ld (ix+1),a
    ld (ix+4),0

    cp 0
    call z,projectile_kill ;kill it if top of screen
    ret

projectile_draw:
    ld a,(ix+7)
    nextreg $34,a

    ;attr 0 (x lsb)
    ld a,(ix+2)
    nextreg $35,a

    ;attr 1 (y)
    ld a,(ix+4)
    ld b,a
    ld a,(ix+1)
    add a,a
    add a,a
    add a,a
    add a,a
    sub b
    nextreg $36,a

    ;attr 2 
    ld a,(ix+5)
    ld b,a
    ld a,(ix+3) ;X8 (msb)
    or b
    nextreg $37,a

    ;attr 3
    ld a,(ix+6)
    nextreg $38,a

    ret





projectile_rotate:
    ld a,(ix+5)
    add a,2
    and %00001110
    ld (ix+5),a
    ret



projectile_kill:
    res 7,(ix+6)
    call projectile_draw

    ld (ix),OUT_OF_WORLD
    ret



projectile_calculate_screen_pos:
    ; ;Y 
    ; ld a,(ix+1)
    ; add a,a
    ; add a,a
    ; add a,a
    ; add a,a ;A*16
    ; ld (ix+4),a

    ld a,(scroll_direction)
    cp LEFT
    jp z,proj_screen_moving_left
    cp RIGHT
    jp z,proj_screen_moving_right

    ret


proj_screen_moving_left:
    ;X (scroll left)
    ld a,(cam_x)
    ld b,a
    ld a,(ix+0) ;wX
    sub b ;wX-camX
    ld hl,0
    add hl,a
    add hl,hl
    add hl,hl
    add hl,hl  
    add hl,hl  
    ld a,(current_scroll)
    ld b,a
    ld a,16
    sub b
    add hl,a
    ld (ix+2),l
    ld (ix+3),h ;X8
    ret

proj_screen_moving_right:
    ;X (scroll left)
    ld a,(cam_x)
    ld b,a
    ld a,(ix) ;wX
    sub b ;wX-camX
    ld hl,0
    add hl,a
    add hl,hl
    add hl,hl
    add hl,hl  
    add hl,hl  
    ld a,(current_scroll)
    ld b,a
    ld a,16
    sub b
    add hl,a  
    ld (ix+2),l
    ld (ix+3),h ;X8

    ret



projectile_check_in_view:
    ld a,(ix)
    ld b,a
    ld a,(cam_x)
    add a,VIEW_WIDTH_META
    cp b
    jp c, proj_set_not_inview

    ld a,(cam_x)
    ld b,a
    ld a,(ix)
    cp b
    jp c, proj_set_not_inview

   
    ; set to inview=yes
    set 7,(ix+6)

    ret

proj_set_not_inview:
    ld (ix),OUT_OF_WORLD
    res 7,(ix+6)
    call projectile_draw

    
    ret
