
game_init:
    call layer2_init
    nextreg $56,14
    ld b,SPRITE_COUNT
    ld hl,$c000
    call sprites_init
    
    call tiles_init 
    call player_init

    ret


game_update:
    ld b,11
    call WaitRasterLine

    call layer2_update
    call check_keys
    call player_update
    call objects_update
    
    ret

game_draw:
    call player_draw
    call objects_draw
    ret


