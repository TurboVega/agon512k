; File:		agon512k.asm
; Purpose:	Use Agon 512KB external RAM in BASIC
; Copyright (C) 2023 by Curtis Whitley
;
; MIT License
;
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
;
; The above copyright notice and this permission notice shall be included in all
; copies or substantial portions of the Software.
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.


		XDEF	src_address
		XDEF	dst_address
		XDEF	block_size
		XDEF	copy_ram
		XDEF	clear_ram

; BASIC uses HIMEM value of &FF00, so we choose enough room below that.
		DEFINE	HIMEM_SEG, ORG=%FEA0
		SEGMENT	HIMEM_SEG
		ALIGN	4

		.ASSUME	ADL = 0


src_address:	DW24	0		; source location within external RAM
				DB		0		; MSB of 32-bit value, ignored
dst_address:	DW24	0		; destination location within external RAM
				DB		0		; MSB of 32-bit value, ignored
block_size:		DW24	0		; number of bytes to copy from source to destination
				DB		0		; MSB of 32-bit value, ignored
byte_value:		DB		0		; byte value used to fill memory
				DW24    0       ; Upper 24 bits of 32-bit value, ignored.

; Copy a block of RAM from the source address to the destination address.
;
; This routine is called in Z80 (non-ADL) mode. It changes to ADL mode to operate.
;
copy_ram:
		stmix					; enable mixed mode operation
		call.sil	copy_adl	; perform the copy in ADL mode
		rsmix					; disable mixed mode operation
		ret

; Clear a block of RAM at the destination address.
;
; This routine is called in Z80 (non-ADL) mode. It changes to ADL mode to operate.
;
clear_ram:
		stmix					; enable mixed mode operation
		ld			a, 0		; load zero for clearing
		call.sil	fill_adl	; perform the fill in ADL mode
		rsmix					; disable mixed mode operation
		ret

; Fill a block of RAM at the destination address with a given byte value.
;
; This routine is called in Z80 (non-ADL) mode. It changes to ADL mode to operate.
;
fill_ram:
		stmix					; enable mixed mode operation
		ld			a, (byte_value) ; load given value for filling memory
		call.sil	fill_adl	; perform the clear in ADL mode
		rsmix					; disable mixed mode operation
		ret

		.ASSUME ADL = 1

; Copy a block of RAM from the source address to the destination address.
;
; This routine runs in ADL mode.
;
copy_adl:
		ld		hl, (src_address) ; get the source address
		ld		de, (dst_address) ; get the destination address
		ld		bc, (block_size) ; get the block size to copy
		ldir					; copy the entire block
		ret.l

; Fill a block of RAM at the destination address with a given byte value.
;
; This routine runs in ADL mode. The byte value is in the A register.
;
fill_adl:
		ld		de, (dst_address) ; get the destination address
		ld		bc, (block_size) ; get the block size to fill
loop:
		ld		(de), a			; clear one byte
		inc		de				; advance pointer
		dec		bc				; decrease byte count
		jp		nz,loop			; back if more to fill
		ret.l
