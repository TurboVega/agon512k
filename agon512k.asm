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

		DEFINE	MY_CODE_SEG, ORG=%FEB0
		SEGMENT	MY_CODE_SEG
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
copy_ram:
	
		call.lil copy_adl		; use ADL mode
		ret

		.ASSUME ADL = 1

copy_adl:
		ld		hl, (src_address) ; get the source address
		ld		de, (dst_address) ; get the destination address
		ld		bc, (block_size) ; get the block size to copy
		ldir					; copy the entire block
		ret.l

		.ASSUME ADL = 0

; Clear a block of RAM at the destination address.
;
clear_ram:
		xor		a				; load zero for clearing
		jr		fill			; perform the fill in ADL mode

; Fill a block of RAM at the destination address with a given byte value.
;
fill_ram:
		ld		a, (byte_value) ; load given value for filling memory
fill:
		call.lil fill_adl		; use ADL mode
		ret

		.ASSUME	ADL = 1

fill_adl:
		ld		de, (dst_address) ; get the destination address
		ld		bc, (block_size) ; get the block size to fill
fill_loop:
		ld		(de), a			; clear one byte
		inc		de				; advance pointer
		dec		bc				; decrease byte count
		jp		nz,fill_loop	; back if more to fill
		ret.l

		.ASSUME ADL = 0
