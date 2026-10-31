;-------------------------------
; MPASM code for PIC Assembler 
;-------------------------------

#DEFINE	ZERO	STATUS,Z
#DEFINE	CARRY	STATUS,C

;-------------------------------
; invent some new commands :-)
;-------------------------------
; Branch on Carry Clear

bcc	MACRO	label
	btfss	CARRY
	goto	label
 ENDM

;-------------------------------
; Branch on Carry Set

bcs	MACRO	label
	btfsc	CARRY
	goto	label
 ENDM

;-------------------------------
; Branch if Equal to Zero

beq	MACRO	label
	btfsc	ZERO
	goto	label
 ENDM

;-------------------------------
; Branch if Not equal to Zero

bne	MACRO	label
	btfss	ZERO
	goto	label
 ENDM

;-------------------------------
; Set Carry

sec	MACRO
	bsf	CARRY
 ENDM

;-------------------------------
; Clear Carry

clc	MACRO
	bcf	CARRY
 ENDM

;-------------------------------
; Move

move	MACRO	to,from
	movlw	from
	movwf	to
 ENDM

;-------------------------------
; Test (set condition bits in PSW)

test	MACRO	variable
	movf	variable,F

 ENDM

;-------------------------------
; 16 bit manipulations
;-------------------------------
; Move 16 Bits

move16	MACRO	hb_des, lb_des, hb_src, lb_src

	move	lb_des,lb_src
	move	hb_des,hb_src

 ENDM

;-------------------------------
; Clear 16 bits

clr16	MACRO	hb_des, lb_des

	clrf	lb_des
	clrf	hb_des

 ENDM

;-------------------------------
; Test 16 bits (set condition bits)

test16	MACRO	hb_src, lb_src
	LOCAL	_lt1

	movf	lb_src,F
	bne	_lt1
	movf	hb_src,F
_lt1

 ENDM

;-------------------------------
; Decrement 16 until Zero

decz16	MACRO	hb_src, lb_src
	LOCAL	_ld1, _ld2

	movf	lb_src,F
	beq	_ld1
	decf	lb_src,F
	goto	_ld2
_ld1	movf	hb_src,F
	beq	_ld2
	decf	hb_src,F
	decf	lb_src,F
_ld2

 ENDM

;-------------------------------
; things to the stack

push	MACRO
	movwf	temp_w
	swapf	STATUS,W
	movwf	temp_s
 ENDM

;-------------------------------
; things from the stack

pop	MACRO
	swapf	temp_s,W
	movwf	STATUS
	swapf	temp_w,F
	swapf	temp_w,W
 ENDM
