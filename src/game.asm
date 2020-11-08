frame_counter db 0

game_init:
    call layer2_init
    nextreg $56,14

    ld b,SPRITE_COUNT
    ld hl,$c000
    call sprites_init
    
    call tiles_init 
    call player_init
    call projectiles_init

    ret


game_update:
    ld b,11
    call WaitRasterLine

    ld a,(frame_counter)
    inc a
    ld (frame_counter),a

    call layer2_update
    call check_keys
    call player_update
    call draw_debug_sprite
    call objects_update
    call projectiles_update
    
    ret

game_draw:
    call player_draw
    call objects_draw
    call projectiles_draw
    ret


