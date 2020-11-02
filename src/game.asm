
game_init:

    nextreg $56,14
    ld b,SPRITE_COUNT
    ld hl,$c000
    call init_sprites

    call init_layer2

    call init_tiles
    
    call player_init

    ; ;supposed to reset all clip window settings??? doesnt seem to work (i only put it here to test it)
    ; nextreg $1c,%00001001
    ; nextreg $1c,%00001001
    ; nextreg $1c,%00001001
    ; nextreg $1c,%00001001

    ret


game_update:
    ld b,11
    call WaitRasterLine
    call check_keys
    call player_update
    call objects_update
    call layer2_update
    ret

game_draw:
    call player_draw
    call objects_draw
    ret


