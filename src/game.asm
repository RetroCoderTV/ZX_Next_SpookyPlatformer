
game_init:
    ; nextreg $15, %00000011
    call init_tiles

    ret


game_update:
    ld b,20
    call WaitRasterLine
    call scroll_right
    ret

game_draw:
    ret