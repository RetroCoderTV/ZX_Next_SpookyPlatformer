


OBJECT_PUMPKIN equ 0
OBJECT_GHOST equ 1
OBJECT_GHOST_WALKER equ 2


;::All objects have 2 frame animation::

;0=isInView
;1=objType
;2=wX
;3=wY
;4,5=XX
;6=Y
;7=att2
;8=att3
;9=att4
;10=slot_ID
;11=sprites specific XOR value

;12=direction
;13=positional offset y
;14,15=positional offset x
objects:
    db FALSE, OBJECT_PUMPKIN, 04, 26  : dw 0 : db 0,  %00000000,%01010000,%00000000,0,1,RIGHT,0 : dw 0
    db FALSE, OBJECT_PUMPKIN, 12, 26  : dw 0 : db 0,  %00000000,%01010000,%00000000,1,1,RIGHT,0 : dw 0
    db FALSE, OBJECT_PUMPKIN, 54, 26  : dw 0 : db 0,  %00000000,%01010000,%00000000,2,1,RIGHT,0 : dw 0
    db FALSE, OBJECT_PUMPKIN, 58, 26  : dw 0 : db 0,  %00000000,%01010000,%00000000,3,1,RIGHT,0 : dw 0
    db FALSE, OBJECT_GHOST, 50, 19 : dw 0 : db 0, %00000000,%01010010,%00000000,11,1,RIGHT,0 : dw 0
    ; db FALSE, OBJECT_GHOST_WALKER, 50, 19 : dw 0 : db 0, %00000000,%01010010,%00000000,11,1,LEFT,0 : dw 0
    db END_OF_ARRAY

OBJECTS_DATA_LENGTH equ 16


GHOST_SPEED equ 2
GHOST_MAX_MOVEMENT_X equ 30



;sX= wX-(offset-VW)*8
;sY= wY*8



objects_init:
    ret



objects_update:
    ld ix,objects
objs_update_start:
    ld a,(ix)
    cp END_OF_ARRAY
    ret z
    
    call object_update

    ld de,OBJECTS_DATA_LENGTH
    add ix,de
    jp objs_update_start




objects_draw:
    ld ix,objects
objs_draw_start:
    ld a,(ix)
    cp END_OF_ARRAY
    ret z

    call object_draw

    ld de,OBJECTS_DATA_LENGTH
    add ix,de
    jp objs_draw_start







object_update:
    call object_check_in_view
    call animate_object

    ld a,(ix+1)
    cp OBJECT_PUMPKIN
    ret z

    call handle_behaviour

    ret



object_check_in_view:
    ld a,(ix+2)
    ld b,a
    ld a,(offset)
    cp b
    jp c, obj_set_not_inview

    ld a,(offset)
    sub VIEW_WIDTH
    ld b,a
    ld a,(ix+2)
    cp b
    jp c, obj_set_not_inview

    ; set to inview=yes
    ld a,(ix+8)
    set 7,a
    ld (ix+8),a

    call object_calculate_screen_pos
    ret

obj_set_not_inview:
    ld a,(ix+8)
    res 7,a
    ld (ix+8),a
    ret




object_calculate_screen_pos:
    ;Y 
    ld a,(ix+3)
    add a,a
    add a,a
    add a,a ;A*8
    ld (ix+6),a

    ld a,(scroll_direction)
    cp LEFT
    jp z,obj_screen_moving_left
    cp RIGHT
    jp z,obj_screen_moving_right

    ret

obj_screen_moving_left:
    ;X (scroll left)
    ld a,(offset)
    sub VIEW_WIDTH
    ld b,a
    ld a,(ix+2) ;wX
    sub b ;wX-camX
    ld hl,0
    add hl,a
    add hl,hl
    add hl,hl
    add hl,hl  
    ld a,(current_scroll)
    add hl,a
    ; ld d,(ix+14) ;xpos offset
    ; ld e,(ix+15) ;xpos offset
    ; add hl,de  
    ld (ix+4),l
    ld (ix+5),h ;X8
    ret

obj_screen_moving_right:
    ;X (scroll left)
    ld a,(offset)
    sub VIEW_WIDTH
    ld b,a
    ld a,(ix+2) ;wX
    sub b ;wX-camX
    ld hl,0
    add hl,a
    add hl,hl
    add hl,hl
    add hl,hl  
    ld a,(current_scroll)
    ld b,a
    ld a,8
    sub b
    add hl,a  
    ; ld d,(ix+14) ;xpos offset
    ; ld e,(ix+15) ;xpos offset
    ; add hl,de  
    ld (ix+4),l
    ld (ix+5),h ;X8

    ret


animate_object:
    ld a,(ix+8)
    and %11000000
    ld b,a
    ld a,(ix+8)
    and %00111111
    xor (ix+11)
    add a,b
    ld (ix+8),a
    ret




object_draw:
    ld a,(ix+10)
    nextreg $34,a

    ;attr 0
    ld a,(ix+4)
    nextreg $35,a

    ;attr 1
    ld a,(ix+6)
    nextreg $36,a

    ;attr 2
    ld a,(ix+7)
    ld b,a
    ld a,(ix+5)
    or b
    nextreg $37,a

    ;attr 3
    ld a,(ix+8)
    nextreg $38,a

    ;attr 4
    ld a,(ix+9)
    nextreg $39,a

    ret 
    






handle_behaviour:
    ld a,(ix+1)
    cp OBJECT_GHOST
    jp z, handle_behaviour_ghost
    cp OBJECT_GHOST_WALKER
    jp z, handle_behaviour_ghost_walker
    ret


handle_behaviour_ghost: 
    ld a,(ix+12) 
    cp LEFT
    jp z,ghost_move_left
    cp RIGHT
    jp z,ghost_move_right

    ret

ghost_move_left:
    ld h,(ix+14)
    ld l,(ix+15)
    add hl,-GHOST_SPEED
    ld (ix+14),h
    ld (ix+15),l

    ld a,h
    or l
    ret nz

    ld a,RIGHT
    ld (ix+12),a

    ret
ghost_move_right:
    ld h,(ix+14)
    ld l,(ix+15)
    add hl,-GHOST_SPEED
    ld (ix+14),h
    ld (ix+15),l

    ld a,l
    cp GHOST_MAX_MOVEMENT_X
    ret nz

    ld a,LEFT
    ld (ix+12),a


    ret


handle_behaviour_ghost_walker:
    ret