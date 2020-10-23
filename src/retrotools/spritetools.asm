VISIBILITY equ %10000000
EXTENDED equ %01000000
MIRROR_X equ %00001000
MIRROR_Y equ %00000100



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Upload spritesheet to 16K FPGA Internal Memory
;; Inputs: B=Sprite Count HL=Sprite data Ptr
;; Outputs: none
;; Destroys: A,BC,HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
init_sprites:
	push bc
	ld a,0							
	ld bc,$303b					
	out (c),a
	pop bc
is_loop:
	push bc							
	ld bc,$005b						
	otir							
	pop bc 							
	djnz is_loop					
	ret 	