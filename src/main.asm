    org 0x8000

    DEVICE ZXSPECTRUMNEXT
	CSPECTMAP main.map


start:
	di
	ld sp,0x7FFE
	nextreg $7,3 ;set Mhz mode (3=28mhz)
	call game_init	
	jp main_loop

main_loop:
	call game_update
	call game_draw
	jp main_loop




STACK_SIZE equ 20
stack_bottom ds STACK_SIZE, 0
stack_top db 0  

	
	include 'retrotools\tools.asm'
	include 'retrotools\constants.asm'
	include 'game.asm'
	include 'retrotools\keycacher.asm'
	include 'retrotools\spritetools.asm'
	include 'levels\levels.asm'
	include 'levels\levelmanager.asm'

	

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
	





	SAVENEX OPEN "main.nex", start , stack_top
    SAVENEX CORE 3, 0, 0      
    SAVENEX CFG 0, 0            
	SAVENEX AUTO
    SAVENEX CLOSE 



