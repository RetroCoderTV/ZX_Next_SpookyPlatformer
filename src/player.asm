    MACRO BREAKPOINT 
		DW $01DD 
	ENDM




PLAYER_SLOT equ 50

PLAYER_DEFAULT_ATTR3 equ %11000000

PLAYER_HEIGHT equ 32

SCROLL_MARKER_X equ 320/2

PLAYER_WALK_SPEED equ 1



player_world_x db 0 ;in cells
player_world_y db 0

px dw 32
py db 0
player_attr_2 db %00001000
player_attr_3 db PLAYER_DEFAULT_ATTR3
player_attr_4 db %00100000

player_animation_timer db 0
PLAYER_ANIMATION_DELAY equ 4


;movement states:
WALKING equ 0
JUMPING equ 1
ATTACKING equ 2
CLIMBING equ 3


player_animation_state db JUMPING


vy dw 0

GRAVITY_FORCE equ 32
JUMP_FORCE equ 64

MAX_DOWN_SPEED equ 7
MAX_UP_SPEED equ 5



player_collided_solid db FALSE



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

    

    ld a,(player_animation_state)
    cp WALKING
    jp z, player_update_walking
    cp JUMPING
    jp z, player_update_jumping
    ; cp ATTACKING
    ; cp CLIMBING


    ret


player_update_walking:
    ld a,(keypressed_D)
    cp TRUE
    call z,plyr_move_right


    ret


player_update_jumping:
    call player_calculate_world_position
    call check_collision_feet
    call apply_gravity
    
    call apply_velocity
    ret

apply_gravity:
    ld hl,(vy)
    ld a,h
    cp MAX_DOWN_SPEED
    ret z
    add hl,GRAVITY_FORCE
    ld (vy),hl


    ret

apply_velocity:
    ld hl,py
    ld b,(hl)
    ld hl,(vy)
    ld h,a
    add a,b
    ld (py),a
    ret


plyr_move_right:
    call player_calculate_world_position
    call check_collision_right

    ld a,(player_collided_solid)
    cp TRUE
    ret z

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


player_calculate_world_position:
    ld a,(py)
    and %11111000
    rrca
    rrca
    rrca
    ld (player_world_y),a
    
    ld hl,(px)
    ld a,l
    and %11111000
    rrca
    rrca
    rrca 
    ld b,a
    ld a,(offset)
    sub VIEW_WIDTH
    ld c,a
    ld a,b
    add a,c    
    ld (player_world_x),a

    ret



check_collision_feet:
    ld hl,level1
    ld a,(player_world_y)
    add a,4
    ld d,a
    ld e,WORLD_WIDTH
    mul d,e
    add hl,de
    ld a,(player_world_x)
    ld e,a
    ld d,0
    add hl,de
    ld a,(hl)
    cp 12
    jp c,collided_solid_feet

    ret
collided_solid_feet:
    ld a,(player_world_y)
    add a,a
    add a,a
    add a,a
    ld (py),a
   
    ld a,WALKING
    ld (player_animation_state),a
    ld hl,0
    ld (vy),hl

    
    ret


check_collision_right:
    ld hl,level1
    ld a,(player_world_y)
    add a,2
    ld d,a
    ld e,WORLD_WIDTH
    mul d,e
    add hl,de
    ld a,(player_world_x)
    add a,1
    ld e,a
    ld d,0
    add hl,de
    ld a,(hl)
    cp 12
    jp c,collided_solid_right

    ld a,FALSE
    ld (player_collided_solid),a

    ret

collided_solid_right:
    
    ld a,TRUE
    ld (player_collided_solid),a
    ret