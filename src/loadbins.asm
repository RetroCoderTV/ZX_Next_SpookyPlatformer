	
    
;;;;;Tiles

   



gg_palette:
    incbin 'assets/caveman.nxp',0

    MMU 6,16
    org $c000

    incbin 'assets/caveman.til',0,TILE_DEFINITIONS_SIZE




;;;sprites
SPRITE_SEGMENTS equ 4
SPRITE_COUNT equ 20
SPRITE_PLAYER_COUNT equ 16
SPRITE_PUMPKIN_START equ 16
SPRITE_PUMPKIN_COUNT equ 2



    MMU 6,14
    org $c000

spikealot_A_1:
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $B6, $49, $00, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $B6, $B6, $B6, $6E, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $92, $B6, $B6, $B6, $B6, $6E;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $49, $49, $92, $B6, $B6;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $6E, $92, $6E, $49, $6E;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $92, $B6, $92, $92, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $48, $B1, $48, $48, $48;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $48, $68, $D6, $92, $0E, $B6;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $68, $D6, $D6, $D6, $D6, $D6;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $00, $68, $68, $68, $68, $B1;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $48, $68, $68, $68, $68, $68;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $92, $68, $68, $48, $68, $48, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $48, $48, $48, $49, $49, $6E;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $B6, $6E, $49, $92, $92, $92;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $49, $00, $B6, $B6, $92, $B6, $B6, $B6;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $6E, $B6, $6E, $00, $49, $B6, $B6, $B6, $92, $6E;

spikealot_A_2:
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $92, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $6E, $49, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $49, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $6E, $49, $49, $00, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $6E, $49, $00, $49, $49, $00, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $00, $49, $6E, $92, $B6, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $49, $6E, $92, $B6, $B6, $B6, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $6E, $00, $6E, $92, $92, $B6, $B6, $92, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $92, $00, $49, $92, $6E, $49, $00, $00, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $6E, $49, $00, $00, $00, $00, $6E, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $6E, $00, $00, $00, $6E, $B6, $B6, $6E, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $00, $00, $49, $00, $6E, $92, $B6, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3;

spikealot_A_3:
	db  $E3, $E3, $E3, $E3, $E3, $E3, $6E, $92, $92, $00, $6E, $49, $6E, $6E, $49, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $49, $6E, $6E, $00, $6E, $B6, $6E, $92, $B6, $6E;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $6E, $00, $B6, $6E, $B6, $6E, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $00, $60, $00, $88, $88, $00, $88;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $00, $60, $60, $00, $60;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $6E, $49, $49, $49, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $B6, $B6, $92, $92, $00;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $B6, $00, $92, $92;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $6E, $B6, $B6;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $92, $B6, $92;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $00, $00;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $92, $B6, $92, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $92, $B6, $92, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $92, $B6, $B6, $92, $6E;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $92, $92, $92, $92, $92, $92;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $00, $00, $00, $00, $00;

spikealot_A_4:
	db  $49, $49, $49, $49, $00, $00, $6E, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $49, $6E, $B6, $92, $00, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $B6, $92, $B6, $B6, $B6, $92, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $B6, $B6, $B6, $B6, $6E, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $92, $B6, $92, $00, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $6E, $00, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $00, $00, $6E, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $6E, $49, $00, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $92, $6E, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $6E, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $00, $6E, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $00, $92, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $00, $92, $92, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $00, $92, $6E, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $6E, $49, $00, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;




spikealot_B_1:
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $B6, $6E, $49, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $92, $B6, $B6, $B6, $92;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $B6, $B6, $B6, $B6, $B6;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $49, $6E, $6E, $92;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $92, $B6, $92, $6E;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $48, $B1, $48, $48;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $48, $68, $D6, $92, $0E;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $68, $D6, $D6, $D6, $D6;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $00, $68, $68, $68, $68;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $48, $68, $68, $68, $68;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $92, $68, $68, $48, $68, $48;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $48, $48, $48, $49, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $B6, $6E, $49, $92, $92;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $B6, $6E, $B6, $B6, $B6;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $49, $49, $B6, $B6, $B6;



spikealot_B_2:
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $6E, $49, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $92, $6E, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $92, $49, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $48, $49, $49, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $B6, $6E, $49, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $D6, $6E, $49, $00, $00, $00, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $B1, $49, $00, $49, $6E, $92, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $68, $49, $49, $92, $92, $B6, $B6, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $00, $6E, $92, $B6, $B6, $B6, $92, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $6E, $00, $6E, $92, $92, $6E, $B6, $92, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $49, $49, $00, $00, $00, $49, $92, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $92, $49, $00, $49, $92, $6E, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $B6, $92, $00, $6E, $B6, $B6, $6E, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;



spikealot_B_3:
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $92, $49, $6E, $B6, $B6;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $92, $49, $49, $6E;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $B6, $49, $92, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $60, $00, $88, $88, $00;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $00, $60, $60, $00;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $6E, $49, $49, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $B6, $6E, $B6, $92;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $00, $92, $92, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $B6, $6E, $00, $49, $6E;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $6E, $6E, $49, $00, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $92, $00, $49, $00, $E3, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $B6, $6E, $00, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $92, $49, $00, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $6E, $B6, $92, $6E, $00, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $49, $6E, $92, $6E, $6E, $6E, $49, $00, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $00, $00, $00, $00, $00, $E3, $E3, $6E;



spikealot_B_4:
	db  $B6, $B6, $B6, $00, $B6, $6E, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $92, $B6, $92, $00, $92, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $6E, $92, $00, $6E, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $88, $00, $60, $60, $00, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $60, $00, $00, $00, $00, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $49, $6E, $6E, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $6E, $6E, $49, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $92, $B6, $6E, $00, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $B6, $B6, $92, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $92, $B6, $00, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $00, $00, $49, $92, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $92, $B6, $92, $92, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $92, $B6, $92, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $E3, $6E, $92, $B6, $6E, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $6E, $92, $B6, $92, $92, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $92, $92, $6E, $00, $00, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;


spikealot_D_1:
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $B6;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $B6, $B6;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $92, $B6, $B6;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $49, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $6E, $92;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $92, $B6;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $48, $B1;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $48, $68, $D6;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $68, $D6, $D6;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $00, $68, $68;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $B6, $B6, $68;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $92, $B6, $B6, $B6;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $92, $B6, $B6, $B6;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $92, $92, $B6;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $49, $92, $B6;



spikealot_D_2:
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $B6, $6E, $49, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $B6, $B6, $6E, $49, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $92, $B6, $B6, $49, $49, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $6E, $49, $6E, $92, $49, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $92, $92, $49, $6E, $49, $49, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $48, $48, $48, $49, $49, $49, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $92, $0E, $B6, $6E, $49, $49, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $D6, $D6, $D6, $6E, $49, $00, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $68, $68, $68, $00, $49, $92, $6E, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $68, $48, $00, $6E, $6E, $B6, $B6, $6E, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $48, $00, $49, $6E, $92, $B6, $B6, $B6, $49, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $49, $49, $00, $49, $6E, $92, $B6, $49, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $B6, $49, $92, $B6, $00, $00, $49, $6E, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $B6, $00, $B6, $B6, $92, $6E, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;



spikealot_D_3:
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $49, $6E, $92;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $92, $49, $6E;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $92, $B6, $6E, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $B6, $6E, $B6;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $60, $00, $88, $88;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $00, $49, $00, $60, $60;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $B6, $49, $6E, $49, $49, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $00, $00, $6E, $00, $B6, $6E, $B6;
	db  $E3, $E3, $E3, $E3, $49, $49, $6E, $92, $92, $92, $00, $49, $00, $6E, $92, $B6;
	db  $E3, $E3, $E3, $E3, $49, $6E, $92, $92, $B6, $92, $6E, $00, $00, $00, $49, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $49, $6E, $92, $6E, $00, $E3, $E3, $E3, $00, $00;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $6E, $00, $E3, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;



spikealot_D_4:
	db  $6E, $00, $92, $6E, $49, $00, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $00, $6E, $6E, $00, $49, $49, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $00, $49, $49, $6E, $6E, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $B6, $92, $92, $92, $49, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $00, $88, $00, $60, $60, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $00, $60, $00, $00, $00, $00, $00, $00, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $49, $49, $49, $49, $00, $49, $92, $6E, $00, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $B6, $6E, $00, $00, $00, $49, $92, $92, $92, $00, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $6E, $00, $B6, $92, $92, $00, $B6, $B6, $6E, $6E, $00, $E3, $E3, $E3, $E3, $E3;
	db  $00, $92, $B6, $B6, $92, $00, $92, $92, $B6, $B6, $00, $E3, $E3, $E3, $E3, $E3;
	db  $00, $49, $6E, $92, $00, $6E, $49, $00, $92, $B6, $92, $00, $E3, $E3, $E3, $E3;
	db  $E3, $00, $00, $00, $00, $00, $00, $E3, $6E, $92, $92, $00, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $6E, $92, $00, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $00, $E3, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;



spikealot_C_1:
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $B6, $6E, $49, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $92, $B6, $B6, $B6, $92;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $B6, $B6, $B6, $B6, $B6;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $49, $6E, $6E, $92;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $92, $B6, $92, $6E;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $48, $B1, $48, $48;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $48, $68, $D6, $92, $0E;
	db  $E3, $E3, $E3, $E3, $E3, $6E, $49, $00, $E3, $E3, $E3, $68, $D6, $D6, $D6, $D6;
	db  $E3, $E3, $E3, $E3, $6E, $92, $B6, $B6, $00, $E3, $49, $00, $68, $68, $68, $68;
	db  $E3, $E3, $E3, $E3, $6E, $92, $92, $B6, $00, $E3, $6E, $48, $68, $68, $68, $68;
	db  $E3, $E3, $E3, $E3, $49, $6E, $6E, $92, $92, $00, $92, $68, $68, $48, $68, $48;
	db  $E3, $E3, $E3, $E3, $E3, $49, $6E, $92, $B6, $00, $B6, $48, $48, $48, $49, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $49, $6E, $6E, $00, $B6, $B6, $6E, $49, $92, $92;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $00, $49, $6E, $B6, $92, $B6, $B6, $B6;



spikealot_C_2:
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $6E, $49, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $92, $6E, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $92, $49, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $48, $49, $49, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $B6, $6E, $49, $49, $00, $00, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $D6, $6E, $49, $00, $00, $49, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $B1, $49, $00, $49, $6E, $92, $B6, $92, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $68, $49, $49, $6E, $92, $B6, $B6, $B6, $92, $00, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $6E, $00, $6E, $92, $92, $B6, $00, $00, $00, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $6E, $92, $00, $49, $6E, $92, $00, $B6, $92, $00, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $92, $6E, $49, $00, $6E, $00, $6E, $92, $B6, $49, $00, $E3, $E3, $E3, $E3, $E3;
	db  $92, $49, $00, $00, $00, $E3, $00, $00, $92, $6E, $00, $E3, $E3, $E3, $E3, $E3;



spikealot_C_3:
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $00, $49, $92, $B6, $B6, $92, $92;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $49, $6E, $6E, $49, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $B6, $49, $92, $B6, $B6;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $6E, $92, $B6, $B6, $B6;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $60, $00, $88, $88, $00, $88;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $00, $60, $60, $00, $60;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $00, $B6, $B6, $B6;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $92, $92, $00, $B6, $92;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $92, $49, $6E, $B6, $B6, $92, $00, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $92, $92, $B6, $B6, $92, $49, $00, $49;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $6E, $92, $92, $6E, $00, $E3, $00;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $49, $92, $49, $00, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $00, $00, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;



spikealot_C_4:
	db  $00, $00, $49, $49, $00, $92, $B6, $B6, $00, $00, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $49, $49, $49, $B6, $B6, $B6, $B6, $B6, $92, $00, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $B6, $6E, $49, $B6, $B6, $B6, $B6, $00, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $92, $49, $00, $92, $B6, $92, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $00, $60, $60, $00, $00, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $00, $00, $00, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $00, $49, $49, $00, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $92, $00, $00, $49, $6E, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $00, $00, $49, $6E, $92, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $6E, $00, $6E, $92, $B6, $6E, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $00, $49, $6E, $6E, $6E, $92, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $00, $00, $00, $00, $49, $6E, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $00, $49, $49, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $00, $00, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;


pumpkin_1:
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $44, $44, $44, $44, $44, $64, $64, $64, $64, $64, $E3, $E3, $E3;
	db  $E3, $E3, $44, $64, $64, $64, $64, $0C, $0C, $64, $A8, $64, $A8, $64, $E3, $E3;
	db  $E3, $44, $64, $64, $A8, $A8, $64, $08, $08, $64, $A8, $A8, $64, $A8, $64, $E3;
	db  $44, $64, $64, $64, $A8, $A8, $64, $08, $08, $64, $A8, $A8, $A8, $64, $A8, $64;
	db  $44, $64, $A8, $64, $A8, $EC, $64, $EC, $EC, $64, $EC, $A8, $A8, $64, $A8, $64;
	db  $44, $64, $A8, $00, $64, $EC, $64, $EC, $EC, $64, $EC, $64, $00, $64, $A8, $64;
	db  $44, $64, $A8, $00, $00, $64, $64, $EC, $EC, $64, $64, $00, $00, $64, $A8, $64;
	db  $44, $64, $A8, $A8, $00, $00, $00, $EC, $EC, $00, $00, $00, $A8, $64, $A8, $64;
	db  $44, $64, $A8, $A8, $A8, $EC, $64, $EC, $EC, $64, $EC, $EC, $A8, $64, $A8, $64;
	db  $44, $64, $A8, $A8, $00, $EC, $64, $EC, $EC, $64, $EC, $00, $A8, $64, $A8, $64;
	db  $20, $64, $64, $A8, $A8, $00, $00, $00, $00, $00, $00, $A8, $A8, $64, $64, $20;
	db  $E3, $44, $64, $64, $A8, $A8, $64, $A8, $A8, $64, $A8, $A8, $64, $64, $44, $E3;
	db  $E3, $44, $44, $64, $64, $64, $64, $44, $44, $64, $64, $64, $64, $44, $44, $E3;
	db  $E3, $E3, $44, $44, $44, $44, $44, $E3, $E3, $44, $44, $44, $44, $44, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;



pumpkin_2:
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $A8, $A8, $A8, $A8, $A8, $A8, $A8, $A8, $A8, $A8, $E3, $E3, $E3;
	db  $E3, $E3, $A8, $EC, $A8, $EC, $A8, $0C, $0C, $A8, $EC, $A8, $EC, $EC, $E3, $E3;
	db  $E3, $A8, $EC, $A8, $EC, $EC, $A8, $08, $08, $A8, $EC, $EC, $A8, $EC, $EC, $E3;
	db  $A8, $EC, $A8, $EC, $EC, $EC, $A8, $08, $08, $A8, $EC, $EC, $EC, $A8, $EC, $EC;
	db  $EC, $EC, $A8, $EC, $EC, $EC, $A8, $EC, $EC, $A8, $EC, $EC, $EC, $A8, $EC, $EC;
	db  $EC, $EC, $A8, $E0, $EC, $EC, $A8, $EC, $EC, $A8, $EC, $EC, $E0, $A8, $EC, $EC;
	db  $EC, $EC, $A8, $E0, $E0, $E0, $A8, $EC, $EC, $A8, $E0, $E0, $E0, $A8, $EC, $EC;
	db  $EC, $EC, $A8, $EC, $E0, $B4, $FC, $EC, $EC, $FC, $B4, $E0, $EC, $A8, $EC, $EC;
	db  $EC, $EC, $A8, $EC, $EC, $EC, $A8, $EC, $EC, $A8, $EC, $EC, $EC, $A8, $EC, $EC;
	db  $EC, $EC, $A8, $EC, $B4, $EC, $A8, $EC, $EC, $A8, $EC, $B4, $EC, $A8, $EC, $EC;
	db  $90, $EC, $A8, $EC, $EC, $B4, $B4, $B4, $B4, $B4, $B4, $EC, $EC, $A8, $EC, $90;
	db  $E3, $B4, $A8, $EC, $EC, $EC, $A8, $EC, $EC, $A8, $EC, $EC, $EC, $A8, $B4, $E3;
	db  $E3, $B4, $B4, $EC, $EC, $EC, $A8, $D8, $D8, $A8, $EC, $EC, $EC, $B4, $B4, $E3;
	db  $E3, $E3, $B4, $B4, $B4, $D8, $D8, $E3, $E3, $D8, $D8, $B4, $B4, $B4, $E3, $E3;
	db  $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3, $E3;


pacghost_1:
	db  $E3, $E3, $E3, $E3, $E3, $7C, $7C, $7C, $7C, $7C, $7C, $E3, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $E3, $E3, $E3;
	db  $E3, $E3, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $E3, $E3;
	db  $E3, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $E3;
	db  $7C, $7C, $FF, $FF, $7C, $7C, $7C, $FF, $FF, $7C, $7C, $7C, $7C, $7C, $7C, $7C;
	db  $7C, $FF, $FF, $FF, $FF, $7C, $FF, $FF, $FF, $FF, $7C, $7C, $7C, $7C, $7C, $7C;
	db  $7C, $03, $03, $FF, $FF, $7C, $03, $03, $FF, $FF, $7C, $7C, $7C, $7C, $7C, $7C;
	db  $7C, $03, $03, $FF, $FF, $7C, $03, $03, $FF, $FF, $7C, $7C, $7C, $7C, $7C, $7C;
	db  $7C, $7C, $FF, $FF, $7C, $7C, $7C, $FF, $FF, $7C, $7C, $7C, $7C, $7C, $7C, $7C;
	db  $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C;
	db  $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C;
	db  $7C, $7C, $08, $08, $08, $08, $08, $08, $08, $08, $7C, $7C, $7C, $7C, $7C, $7C;
	db  $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C;
	db  $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C;
	db  $7C, $7C, $E3, $E3, $7C, $7C, $7C, $E3, $E3, $7C, $7C, $7C, $E3, $E3, $7C, $7C;
	db  $7C, $E3, $E3, $E3, $E3, $7C, $7C, $E3, $E3, $7C, $7C, $E3, $E3, $E3, $E3, $7C;



pacghost_2:
	db  $E3, $E3, $E3, $E3, $E3, $7C, $7C, $7C, $7C, $7C, $7C, $E3, $E3, $E3, $E3, $E3;
	db  $E3, $E3, $E3, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $E3, $E3, $E3;
	db  $E3, $E3, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $E3, $E3;
	db  $E3, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $E3;
	db  $7C, $7C, $FF, $FF, $7C, $7C, $7C, $FF, $FF, $7C, $7C, $7C, $7C, $7C, $7C, $7C;
	db  $7C, $FF, $FF, $FF, $FF, $7C, $FF, $FF, $FF, $FF, $7C, $7C, $7C, $7C, $7C, $7C;
	db  $7C, $03, $03, $FF, $FF, $7C, $03, $03, $FF, $FF, $7C, $7C, $7C, $7C, $7C, $7C;
	db  $7C, $03, $03, $FF, $FF, $7C, $03, $03, $FF, $FF, $7C, $7C, $7C, $7C, $7C, $7C;
	db  $7C, $7C, $FF, $FF, $7C, $7C, $7C, $FF, $FF, $7C, $7C, $7C, $7C, $7C, $7C, $7C;
	db  $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C;
	db  $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C;
	db  $7C, $7C, $08, $08, $08, $08, $08, $08, $08, $08, $7C, $7C, $7C, $7C, $7C, $7C;
	db  $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C;
	db  $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C;
	db  $7C, $E3, $7C, $7C, $7C, $E3, $E3, $7C, $7C, $7C, $E3, $E3, $7C, $7C, $7C, $7C;
	db  $7C, $E3, $E3, $7C, $E3, $E3, $E3, $E3, $7C, $E3, $E3, $E3, $E3, $7C, $E3, $7C;



    
    
    
;;;;;;Fonts
    
    
    
    MMU 6,17
	org 0xC000

	ds 64,0
	; incbin "fonts/font1.spr"
	; incbin "fonts/font2.spr"
	; incbin "fonts/font3.spr"
	; incbin "fonts/font4.spr"
	; incbin "fonts/font5.spr"
	; incbin "fonts/font6.spr"
	incbin "fonts/font7.spr"
	; incbin "fonts/font8.spr"
	; incbin "fonts/font9.spr"
	; incbin "fonts/font10.spr"
	; incbin "fonts/font11.spr"
	; incbin "fonts/font12.spr"
	; incbin "fonts/font13.spr"
	; incbin "fonts/font14.spr"
	; incbin "fonts/font15.spr"
	; incbin "fonts/font16.spr"
	; ; incbin "fonts/font17.spr"
	; incbin "fonts/font18.spr" *not mapped same as others (?)
	



;; Layer2

	; MMU 7 n,40
	; org $e000
	; incbin "assets/sky.bmp", 1078

	MMU 7 n,40
	org $e000
	incbin "assets/skybig.bmp", 1078