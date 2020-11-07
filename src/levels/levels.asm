; another way to check solids (if not in order)
super_solids:
    db 17,19,49

SOLIDS_LENGTH equ 3

;INPUTS:
;A=value to test against 'solids' array
check_solid:
    ld hl,super_solids
    ld bc,SOLIDS_LENGTH
    cpir
    ret


;Platform::
;01 03 03 01*
;17 19 19 17*
;02 04 04 02*
;18 20 20 18*


LEVEL_START_ADDRESS equ $4500 ;half way down
LEVEL_WIDTH_META equ 80
LEVEL_HEIGHT_META equ 8


TILE_ATTR_NOMIRROR equ %00000000
TILE_ATTR_MIRROR equ %00001000

superlevel:
    db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
    db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,01,03,03,03,33,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
    db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,17,19,19,19,49,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
    db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,01,33,00,00,01,03,03,03,33,00,02,20,20,20,34,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
    db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,01,03,03,03,03,03,03,03,03,03,03,03,33,00,00,00,00,00,00,00,00,00,00,17,19,00,00,17,19,19,19,49,00,18,19,19,19,50,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
    db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,17,19,19,19,19,19,19,19,19,19,19,19,49,00,00,00,00,00,01,03,03,03,03,02,49,00,00,02,20,20,20,34,00,02,20,20,20,34,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
    db 00,01,03,03,03,03,03,33,00,00,01,03,03,03,03,03,03,03,03,33,02,20,20,20,20,20,20,20,20,20,20,20,34,03,03,03,33,00,17,19,19,19,19,19,34,00,00,18,19,19,19,50,00,18,19,19,19,50,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
    db 00,17,19,19,19,19,19,49,19,19,17,19,19,19,19,19,19,19,19,49,18,19,19,19,19,19,19,19,19,19,19,19,50,19,19,19,49,00,02,20,20,20,20,20,50,00,00,02,20,20,20,34,00,02,20,20,20,34,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00


supertiles:
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR   ;supertile 0
    db 2,TILE_ATTR_NOMIRROR,3,TILE_ATTR_NOMIRROR,34,TILE_ATTR_NOMIRROR,35,TILE_ATTR_NOMIRROR ;1
    db 4,TILE_ATTR_NOMIRROR,5,TILE_ATTR_NOMIRROR,36,TILE_ATTR_NOMIRROR,37,TILE_ATTR_NOMIRROR ;2
    db 6,TILE_ATTR_NOMIRROR,7,TILE_ATTR_NOMIRROR,38,TILE_ATTR_NOMIRROR,39,TILE_ATTR_NOMIRROR ;3
    db 8,TILE_ATTR_NOMIRROR,9,TILE_ATTR_NOMIRROR,40,TILE_ATTR_NOMIRROR,41,TILE_ATTR_NOMIRROR ;4
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR
    db 66,TILE_ATTR_NOMIRROR,67,TILE_ATTR_NOMIRROR,98,TILE_ATTR_NOMIRROR,99,TILE_ATTR_NOMIRROR ;17 
    db 68,TILE_ATTR_NOMIRROR,69,TILE_ATTR_NOMIRROR,100,TILE_ATTR_NOMIRROR,101,TILE_ATTR_NOMIRROR ;18
    db 70,TILE_ATTR_NOMIRROR,71,TILE_ATTR_NOMIRROR,102,TILE_ATTR_NOMIRROR,103,TILE_ATTR_NOMIRROR ;19
    db 72,TILE_ATTR_NOMIRROR,73,TILE_ATTR_NOMIRROR,104,TILE_ATTR_NOMIRROR,105,TILE_ATTR_NOMIRROR ;20
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR ;30
    db 0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR,0,TILE_ATTR_NOMIRROR ;31 - end of definitions
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR ;32 0*
    db 3,TILE_ATTR_MIRROR,2,TILE_ATTR_MIRROR,35,TILE_ATTR_MIRROR,34,TILE_ATTR_MIRROR ;33 1*
    db 5,TILE_ATTR_MIRROR,4,TILE_ATTR_MIRROR,37,TILE_ATTR_MIRROR,36,TILE_ATTR_MIRROR ;34 2*
    db 7,TILE_ATTR_MIRROR,6,TILE_ATTR_MIRROR,39,TILE_ATTR_MIRROR,38,TILE_ATTR_MIRROR ;35 3*
    db 9,TILE_ATTR_MIRROR,8,TILE_ATTR_MIRROR,41,TILE_ATTR_MIRROR,40,TILE_ATTR_MIRROR ;36 4*
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR
    db 67,TILE_ATTR_MIRROR,66,TILE_ATTR_MIRROR,99,TILE_ATTR_MIRROR,98,TILE_ATTR_MIRROR ;49 17* 
    db 69,TILE_ATTR_MIRROR,68,TILE_ATTR_MIRROR,101,TILE_ATTR_MIRROR,100,TILE_ATTR_MIRROR ;50 18*
    db 71,TILE_ATTR_MIRROR,70,TILE_ATTR_MIRROR,103,TILE_ATTR_MIRROR,102,TILE_ATTR_MIRROR ;19*
    db 73,TILE_ATTR_MIRROR,72,TILE_ATTR_MIRROR,105,TILE_ATTR_MIRROR,104,TILE_ATTR_MIRROR ;20*
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR ;30*
    db 0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR,0,TILE_ATTR_MIRROR ;31*
    ;supertile 31 is last