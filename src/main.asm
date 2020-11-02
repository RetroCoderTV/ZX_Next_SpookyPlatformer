    org 0x8000

    DEVICE ZXSPECTRUMNEXT
	CSPECTMAP main.map


start:
	di
	ld sp,0x7FFE
	nextreg $7,3 ;set Mhz mode (3=28mhz)
	nextreg $15,%00001011 ;sprites/layers system register
	call game_init	
	jp main_loop

main_loop:
	call game_update
	call game_draw
	jp main_loop




STACK_SIZE equ 20
stack_bottom ds STACK_SIZE, 0
stack_top db 0  

	include 'retrotools\constants.asm'
	include 'retrotools\tools.asm'

	include 'player.asm'
	include 'objects.asm'
	include 'game.asm'
	include 'retrotools\keycacher.asm'
	include 'retrotools\spritetools.asm'
	include 'levels\levels.asm'
	include 'levels\levelmanager.asm'
	include 'assets\sprites.asm'


	include 'loadbins.asm'



	SAVENEX OPEN "main.nex", start , stack_top
    SAVENEX CORE 3, 0, 0      
    SAVENEX CFG 0, 0            
	SAVENEX AUTO
    SAVENEX CLOSE 



