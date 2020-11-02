    




PLAYER_SLOT equ 58

PLAYER_DEFAULT_ATTR3 equ %11000000

PLAYER_HEIGHT equ 32

SCROLL_MARKER_X equ 320/2

PLAYER_WALK_SPEED equ 1



player_world_x db 0 ;in cells
player_world_y db 0

px dw 32
py db 160
player_attr_2 db %00001000
player_attr_3 db PLAYER_DEFAULT_ATTR3
player_attr_4 db %00100000

player_animation_timer db 0
PLAYER_ANIMATION_DELAY equ 4


;movement states:
WALKING equ 0xA
JUMPING equ 0xB
ATTACKING equ 0xC
CLIMBING equ 0xD

player_animation_state db JUMPING


vy dw 0

DOWN_FORCE equ 32
UP_FORCE equ 64

MAX_DOWN_SPEED equ 7
MAX_UP_SPEED equ 5



player_collided_solid db FALSE


player_jump_direction db DOWN
player_jump_point db 208
PLAYER_JUMP_HEIGHT equ 9
player_grounded db FALSE


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
    

    ld a,(keypressed_A)
    cp TRUE
    call z,plyr_move_left_start

    ld a,(keypressed_D)
    cp TRUE
    call z,plyr_move_right_start

    ld a,(keypressed_Space)
    cp TRUE
    call z,player_jump_start

    

    ; ; ; ; ; ; ; ; ; call check_grounded

    ret

player_jump_start:
    ; ld a,(keypressed_Space_Held)
    ; cp TRUE
    ; ret z

    ld a,(player_animation_state)
    cp JUMPING
    ret z

    ld a,JUMPING
    ld (player_animation_state),a
    
    ld a,(py)
    ld (player_jump_point),a

    ld a,UP
    ld (player_jump_direction),a

    jp player_update


player_update_jumping:  
    ld a,(keypressed_A)
    cp TRUE
    call z,plyr_move_left_start

    ld a,(keypressed_D)
    cp TRUE
    call z,plyr_move_right_start

    call player_calculate_world_position
    ; ; ; ; ; ; ; call check_collision_feet
    
    ld a,(player_jump_point)
    sub PLAYER_JUMP_HEIGHT
    ld b,a
    ld a,(py)
    cp b
    call c,plyr_set_jump_down

    
    ld a,(player_jump_direction)
    cp UP
    push af
    call z, apply_force_up
    pop af
    cp DOWN
    push af
    call z, apply_force_down
    pop af
    

    
    call apply_velocity

   
    ret




plyr_set_jump_down:
    ld a,DOWN
    ld (player_jump_direction),a
    ret

apply_force_up:
    ; call apply_velocity_up
    ld hl,(vy)
    ld a,h
    cp -MAX_UP_SPEED
    ret z
    
    add hl,-UP_FORCE*2
    ld (vy),hl
    ret
apply_force_down:
    ; call apply_velocity_down
    ld hl,(vy)
    ld a,h
    cp MAX_DOWN_SPEED
    ret z
    add hl,DOWN_FORCE
    ld (vy),hl
    ret

apply_velocity:
    ld hl,py
    ld b,(hl)
    ld hl,(vy)
    ld a,h
    add a,b
    ld (py),a
    ret



plyr_move_left_start:
    ld a,(player_attr_2)
    bit 3,a
    jp z,plyr_move_left

    ld a,(player_attr_2)
    res 3,a
    ld (player_attr_2),a

    ld hl,(px)
    add hl,-16
    ld (px),hl
plyr_move_left:
    call player_calculate_world_position
    ; ; ; ; ; ; ; ; call check_collision_left

    ld a,(player_collided_solid)
    cp TRUE
    ret z

    ld a,(player_animation_timer)
    cp PLAYER_ANIMATION_DELAY
    call nc, player_animate_walk

    ld hl,(px)
    ld a,h
    cp 0
    jp nz,p_move_left
    ld a,l
    cp SCROLL_MARKER_X+1
    jp c,scroll_left
    jp nc,p_move_left
        
p_move_left
    add hl,-PLAYER_WALK_SPEED
    ld (px),hl
    ret


plyr_move_right_start:
    ld a,(player_attr_2)
    bit 3,a
    jp nz,plyr_move_right

    ld a,(player_attr_2)
    set 3,a
    ld (player_attr_2),a

    ld hl,(px)
    add hl,16
    ld (px),hl
plyr_move_right:
    call player_calculate_world_position
    ; ; ; ; ; ; ; ; ; ; call check_collision_right

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
    cp SPRITE_PLAYER_COUNT-SPRITE_SEGMENTS
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



; check_collision_feet:
;     ld a,(player_animation_state)
;     cp JUMPING
;     ret nz

;     ld a,(player_jump_direction)
;     cp DOWN
;     ret nz

;     ; ld hl,level1
;     ; ld a,(player_world_y)
;     ; add a,4
;     ; ld d,a
;     ; ld e,WORLD_WIDTH
;     ; mul d,e
;     ; add hl,de
;     ; ld a,(player_world_x)
;     ; ld e,a
;     ; ld d,0
;     ; add hl,de
;     ; ld a,(hl)
;     ; cp 12
;     ; jp c,collided_solid_feet

;     ld hl,level1
;     ld a,(player_world_y)
;     add a,4
;     ld d,a
;     ld e,WORLD_WIDTH
;     mul d,e
;     add hl,de
;     ld a,(player_world_x)
;     add a,1
;     ld e,a
;     ld d,0
;     add hl,de
;     ld a,(hl)
;     cp 12
;     jp c,collided_solid_feet

;     ld hl,level1
;     ld a,(player_world_y)
;     add a,4
;     ld d,a
;     ld e,WORLD_WIDTH
;     mul d,e
;     add hl,de
;     ld a,(player_world_x)
;     add a,2
;     ld e,a
;     ld d,0
;     add hl,de
;     ld a,(hl)
;     cp 12
;     jp c,collided_solid_feet

;     ; ld hl,level1
;     ; ld a,(player_world_y)
;     ; add a,4
;     ; ld d,a
;     ; ld e,WORLD_WIDTH
;     ; mul d,e
;     ; add hl,de
;     ; ld a,(player_world_x)
;     ; add a,3
;     ; ld e,a
;     ; ld d,0
;     ; add hl,de
;     ; ld a,(hl)
;     ; cp 12
;     ; jp c,collided_solid_feet

;     ret









; check_grounded:
;     ld a,(player_jump_direction)
;     cp UP
;     ret z

;     ld hl,level1
;     ld a,(player_world_y)
;     add a,5
;     ld d,a
;     ld e,WORLD_WIDTH
;     mul d,e
;     add hl,de
;     ld a,(player_world_x)
;     ld e,a
;     ld d,0
;     add hl,de
;     ld a,(hl)
;     cp 12
;     jp c,player_set_grounded ;if under 12, the tile is solid

;     ld hl,level1
;     ld a,(player_world_y)
;     add a,5
;     ld d,a
;     ld e,WORLD_WIDTH
;     mul d,e
;     add hl,de
;     ld a,(player_world_x)
;     add a,1
;     ld e,a
;     ld d,0
;     add hl,de
;     ld a,(hl)
;     cp 12
;     jp c,player_set_grounded ;if under 12, the tile is solid

;     ld hl,level1
;     ld a,(player_world_y)
;     add a,5
;     ld d,a
;     ld e,WORLD_WIDTH
;     mul d,e
;     add hl,de
;     ld a,(player_world_x)
;     add a,2
;     ld e,a
;     ld d,0
;     add hl,de
;     ld a,(hl)
;     cp 12
;     jp c,player_set_grounded ;if under 12, the tile is solid

;     ld hl,level1
;     ld a,(player_world_y)
;     add a,5
;     ld d,a
;     ld e,WORLD_WIDTH
;     mul d,e
;     add hl,de
;     ld a,(player_world_x)
;     add a,3
;     ld e,a
;     ld d,0
;     add hl,de
;     ld a,(hl)
;     cp 12
;     jp c,player_set_grounded ;if under 12, the tile is solid

;     ;else not grounded:
;     ld a,FALSE
;     ld (player_grounded),a
;     ;set mode to jumping>down
;     ld a,JUMPING
;     ld (player_animation_state),a
;     ld a,DOWN
;     ld (player_jump_direction),a

;     ret



; player_set_grounded:
;     ld a,TRUE
;     ld (player_grounded),a
;     ret


; collided_solid_feet:
;     ld a,(player_world_y)
;     add a,a
;     add a,a
;     add a,a
;     ld (py),a
   
;     ld a,(player_jump_direction)
;     cp UP
;     ret z

;     ld a,WALKING
;     ld (player_animation_state),a
;     ld hl,0
;     ld (vy),hl

    
;     ret



; check_collision_left:
;     ld hl,level1
;     ld a,(player_world_y)
;     add a,2
;     ld d,a
;     ld e,WORLD_WIDTH
;     mul d,e
;     add hl,de
;     ld a,(player_world_x)
;     ld e,a
;     ld d,0
;     add hl,de
;     ld a,(hl)
;     cp 12
;     jp c,collided_solid_sideways

;     ld a,FALSE
;     ld (player_collided_solid),a

;     ret



; check_collision_right:
;     ld hl,(px)
;     ld a,h
;     cp 0
;     jp nz, check_collision_right_x8

;     ld hl,level1
;     ld a,(player_world_y)
;     ld d,a
;     ld e,WORLD_WIDTH
;     mul d,e
;     add hl,de
;     ld a,(player_world_x)
;     add a,1
;     ld e,a
;     ld d,0
;     add hl,de
;     ld a,(hl)
;     cp 12
;     jp c,collided_solid_sideways

;     ld hl,level1
;     ld a,(player_world_y)
;     add a,1
;     ld d,a
;     ld e,WORLD_WIDTH
;     mul d,e
;     add hl,de
;     ld a,(player_world_x)
;     add a,1
;     ld e,a
;     ld d,0
;     add hl,de
;     ld a,(hl)
;     cp 12
;     jp c,collided_solid_sideways

;     ld hl,level1
;     ld a,(player_world_y)
;     add a,2
;     ld d,a
;     ld e,WORLD_WIDTH
;     mul d,e
;     add hl,de
;     ld a,(player_world_x)
;     add a,1
;     ld e,a
;     ld d,0
;     add hl,de
;     ld a,(hl)
;     cp 12
;     jp c,collided_solid_sideways

;     ld hl,level1
;     ld a,(player_world_y)
;     add a,3
;     ld d,a
;     ld e,WORLD_WIDTH
;     mul d,e
;     add hl,de
;     ld a,(player_world_x)
;     add a,1
;     ld e,a
;     ld d,0
;     add hl,de
;     ld a,(hl)
;     cp 12
;     jp c,collided_solid_sideways



;     ld a,FALSE
;     ld (player_collided_solid),a

;     ret

; check_collision_right_x8:
;     ld hl,level1
;     ld a,(player_world_y)
;     ld d,a
;     ld e,WORLD_WIDTH
;     mul d,e
;     add hl,de
;     ld a,(player_world_x)
;     add a,33
;     ld e,a
;     ld d,0
;     add hl,de
;     ld a,(hl)
;     cp 12
;     jp c,collided_solid_sideways

;     ld hl,level1
;     ld a,(player_world_y)
;     add a,1
;     ld d,a
;     ld e,WORLD_WIDTH
;     mul d,e
;     add hl,de
;     ld a,(player_world_x)
;     add a,33
;     ld e,a
;     ld d,0
;     add hl,de
;     ld a,(hl)
;     cp 12
;     jp c,collided_solid_sideways

;     ld hl,level1
;     ld a,(player_world_y)
;     add a,2
;     ld d,a
;     ld e,WORLD_WIDTH
;     mul d,e
;     add hl,de
;     ld a,(player_world_x)
;     add a,33
;     ld e,a
;     ld d,0
;     add hl,de
;     ld a,(hl)
;     cp 12
;     jp c,collided_solid_sideways

;     ld hl,level1
;     ld a,(player_world_y)
;     add a,3
;     ld d,a
;     ld e,WORLD_WIDTH
;     mul d,e
;     add hl,de
;     ld a,(player_world_x)
;     add a,33
;     ld e,a
;     ld d,0
;     add hl,de
;     ld a,(hl)
;     cp 12
;     jp c,collided_solid_sideways



;     ld a,FALSE
;     ld (player_collided_solid),a

;     ret






; collided_solid_sideways:
;     ld a,TRUE
;     ld (player_collided_solid),a
;     ret