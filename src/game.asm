
game_init:

    nextreg $56,14
    ld b,SPRITE_COUNT
    ld hl,$c000
    call init_sprites

    nextreg $15,%00000011
    call init_tiles
    
    call player_init

    ret


game_update:
    ld b,11
    call WaitRasterLine
    call check_keys
    call player_update
    call objects_update
    ret

game_draw:
    call player_draw
    call objects_draw
    ret


