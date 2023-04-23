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


		XDEF	empI, emfG8, emfG16, emfG24, emfG32, empGS, emfGF
		XDEF	emfG8AI, emfG16AI, emfG24AI, emfG32AI, empGSAI, emfGFAI
		XDEF	empP8, empP16, empP24, empP32, empPS, empPF
		XDEF	empP8AI, empP16AI, empP24AI, empP32AI, empPSAI, empPFAI
		XDEF	empCMB, empXMB, empZMB

		DEFINE	MY_CODE_SEG, SPACE=RAM, ORG=%4F000
		SEGMENT	MY_CODE_SEG
		ALIGN	4

		.ASSUME	ADL = 0

emdV8:					; Value parameter as 8 bits
emdV16:					; Value parameter as 16 bits
emdV24:					; Value parameter as 24 bits
emdV32:					; Value parameter as 32 bits
empVF:					; Value parameter as float
emdVS:		ds		256	; Value parameter as string
emdSA:		ds		4	; Source address parameter
emdDA:		ds		4	; Destination address parameter
emdAI:		ds		4	; Array index parameter
emdRC:		ds		4	; Repeat count parameter

empI: ; Initialize upper RAM
; Usage: CALL empI%
			ld.lil	de,0
			ld.lil	hl,50000H
			ld.lil	bc,70000H
loop1:		ld.lil	(hl),de
			dec.lil	bc
			jr		nz,loop1
			ret

emfG8AI: ; Get 8-bit item from array
; Usage: !emdSA% = sourceaddress: !emdAI% = array index: var%=USR(emfG8AI%) 
			call.lil	src_index8
emfG8: ; Get 8-bit value
; Usage: !emdSA% = sourceaddress: var%=USR(emfG8%) 
			ld.lil	ix,emdSA
			ld.lil	iy,emdV8
			ld.l	a,(ix)
			ld.lil	(iy),a
			xor		a
			ld.l	(iy+1),a
			ld.l	(iy+2),a
			ld.l	(iy+3),a
			ret

emfG16AI: ; Get 16-bit item from array
; Usage: !emdSA% = sourceaddress: !emdAI% = array index: var%=USR(emfG16IA%) 
			call.lil	src_index16
emfG16: ; Get 16-bit value
; Usage: !emdSA% = sourceaddress: var%=USR(emfG16%)
			ld.lil	ix,emdSA
			ld.lil	iy,emdV16
			ld.l	a,(ix)
			ld.lil	(iy),a
			ld.l	a,(ix+1)
			ld.l	(iy+1),a
			xor		a
			ld.l	(iy+2),a
			ld.l	(iy+3),a
			ret

emfG24AI: ; Get 24-bit item from array
; Usage: !emdSA% = sourceaddress: !emdAI% = array index: var%=USR(emfG24AI%) 
			call.lil	src_index24
emfG24: ; Get 24-bit value
; Usage: !emdSA% = sourceaddress: var%=USR(emfG24%)
			ld.lil	ix,emdSA
			ld.lil	iy,emdV24
			ld.lil	de,(ix)
			ld.lil	(iy),de
			xor		a
			ld.l	(iy+3),a
			ret

emfG32AI: ; Get 32-bit item from array
; Usage: !emdSA% = sourceaddress: !emdAI% = array index: var%=USR(emfG32AI%) 
			call.lil	src_index32
emfG32: ; Get 32-bit value
; Usage: !emdSA% = sourceaddress: var%=USR(emfG32%)
			ld.lil	ix,emdSA
			ld.lil	iy,emdV32
			ld.lil	de,(ix)
			ld.lil	(iy),de
			ld.l	a,(ix+3)
			ld.l	(iy+3),a
			ret

empGSAI: ; Get String (0..255 characters) item from array
; Usage: !emdSA% = sourceaddress: !emdAI% = array index: CALL empGSAI%: var$ = $emdVS%
			call.lil	src_index_s
empGS: ; Get String (0..255 characters)
; Usage: !emdSA% = sourceaddress: CALL empGS%: var$=$emdVS%
			ld.lil	ix,emdSA
			ld.lil	iy,emdVS
			ld		b,0
loop2:
			ld.l	a,(ix)
			ld.l	(iy),a
			cp		a,0DH
			jr		z,done2
			inc.l	ix
			inc.l	iy
			dec		b
			jr		nz,loop2
done2:		ret

emfGFAI: ; Get Float (40 bits) item from array
			call.lil	src_index_f
emfGF: ; Get Float (40 bits)
			ret

empP8AI: ; Put 8-bit item into array
; Usage: !emdDA% = destinationaddress: !emdAI% = array index: !emdV8% = value: CALL empP8AI%
; Or:    !emdDA% = destinationaddress: !emdAI% = array index: ?emdV8% = value: CALL empP8AI%
			call.lil	dst_index8
empP8: ; Put 8-bit value
; Usage: !emdDA% = destinationaddress: !emdV8% = value: CALL empP8%
; Or:    !emdDA% = destinationaddress: ?emdV8% = value: CALL empP8%
			ld.lil	ix,emdV8
			ld.lil	iy,emdDA
			ld.l	a,(ix)
			ld.lil	(iy),a
			ret

empP16AI: ; Put 16-bit item into array
; Usage: !emdDA% = destinationaddress: !emdAI% = array index: !emdV16% = value: CALL empP16AI%
			call.lil	dst_index16
empP16: ; Put 16-bit value
; Usage: !emdDA% = destinationaddress: !emdV16% = value: CALL empP16%
			ld.lil	ix,emdV16
			ld.lil	iy,emdDA
			ld.l	a,(ix)
			ld.lil	(iy),a
			ld.l	a,(ix+1)
			ld.l	(iy+1),a
			ret

empP24AI: ; Put 24-bit item into array
; Usage: !emdDA% = destinationaddress: !emdAI% = array index: !emdV24% = value: CALL empP24AI%
			call.lil	dst_index24
empP24: ; Put 24-bit value
; Usage: !emdDA% = destinationaddress: !emdV24% = value: CALL empP24%
			ld.lil	ix,emdV24
			ld.lil	iy,emdDA
			ld.lil	de,(ix)
			ld.lil	(iy),de
			ret

empP32AI: ; Put 32-bit item into array
; Usage: !emdDA% = destinationaddress: !emdAI% = array index: !emdV32% = value: CALL empP32AI%
			call.lil	dst_index32
empP32: ; Pet 32-bit value
; Usage: !emdDA% = destinationaddress: !emdV32% = value: CALL empP32%
			ld.lil	ix,emdV32
			ld.lil	iy,emdDA
			ld.lil	de,(ix)
			ld.lil	(iy),de
			ld.l	a,(ix+3)
			ld.l	(iy+3),a
			ret

empPSAI: ; Put String (0..255 characters) item into array
; Usage: !emdDA% = destinationaddress: !emdAI% = array index: $emdVS% = stringvalue: CALL empPSAI%
			call.lil	dst_index_s
empPS: ; Put String (0..255 characters)
; Usage: !emdDA% = destinationaddress: !emdVS% = stringvalue: CALL empPS%
			ld.lil	ix,emdVS
			ld.lil	iy,emdDA
			ld		b,0
loop3:
			ld.l	a,(ix)
			ld.l	(iy),a
			cp		a,0DH
			jr		z,done3
			inc.l	ix
			inc.l	iy
			dec		b
			jr		nz,loop3
done3:		ret

empPFAI: ; Put Float (40 bits) item into array
			call.lil	dst_index_f
empPF: ; Put Float (40 bits)
			ret

empCMB: ; Copy memory block
; Usage: !emdSA% = sourceaddress: !emdDA% = destinationaddress: !emdRC% = repeatcount: CALL empCMB%
			ret

empXMB: ; Exchange (swap) memory blocks
; Usage: !emdSA% = sourceaddress: !emdDA% = destinationaddress: !emdRC% = 
			ret

empZMB: ; Zero memory block
; Usage: !emdDA% = destinationaddress: !emdRC% = repeatcount: CALL empZMB%
			ret

src_index32: ; Add 4x array index to the source address
			call.lil	src_index8
src_index24: ; Add 3x array index to the source address
			call.lil	src_index8
src_index16: ; Add 2x array index to the source address
			call.lil	src_index8
src_index8: ; Add 1x array index to the source address
			ld.lil	ix,emdSA
add_to_addr:
			ld.lil	a,(emdAI)
			add		a,(ix)
			ld.lil	(ix),a
			ld.lil	a,(emdAI+1)
			adc		a,(ix+1)
			ld.lil	(ix+1),a
			ld.lil	a,(emdAI+2)
			adc		a,(ix+2)
			ld.lil	(ix+2),a
			ret.l

src_index_s:
			ret.l

src_index_f:
			ret.l

dst_index32: ; Add 4x array index to the destination address
			call.lil	dst_index8
dst_index24: ; Add 3x array index to the destination address
			call.lil	dst_index8
dst_index16: ; Add 2x array index to the destination address
			call.lil	dst_index8
dst_index8: ; Add 1x array index to the destination address
			ld.lil	ix,emdDA
			jr		add_to_addr

dst_index_s:
			ret.l

dst_index_f:
			ret.l
