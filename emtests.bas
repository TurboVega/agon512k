10 REM emtests.bas
20 HIMEM=&F000
30 PROC_empI
40 !emdSA%=emBase%+emdV8%: ?emdV8%=&5A: PRINT "01: ";~USR(emfG8%)
50 !emdSA%=emBase%+emdV8%: ?emdV8%=&A5: PRINT "02: ";~USR(emfG8%)
60 !emdSA%=emBase%+emdV16%: !emdV16%=&6789: PRINT "03: ";~USR(emfG16%)
70 !emdSA%=emBase%+emdV16%: !emdV16%=&B3C2: PRINT "04: ";~USR(emfG16%)
80 !emdSA%=emBase%+emdV32%: !emdV32%=&16273849: PRINT "05: ";~USR(emfG32%)
90 !emdSA%=emBase%+emdV32%: !emdV32%=&A6B7D3C5: PRINT "06: ";~USR(emfG32%)
64999 END
65000 DEF PROC_empI
65001 emdV8%=&F000
65002 emdV16%=emdV8%
65003 emdV24%=emdV8%
65004 emdV32%=emdV8%
65005 emdVF%=emdV8%
65006 emdVS%=emdV8%
65007 emdSA%=&F100
65008 emdDA%=&F104
65009 emdAI%=&F108
65010 emdRC%=&F10C
65011 empI%=&F110
65020 emfG8%=&F12C
65030 emfG16%=&F143
65040 emfG24%=&F15D
65050 emfG32%=&F179
65060 empGS%=&F
65070 emfGF%=&F
65080 emfG8AI%=&F
65090 emfG16AI%=&F
65100 emfG24AI%=&F
65110 emfG32AI%=&F
65120 empGSAI%=&F
65130 emfGFAI%=&F
65140 empP8%=&F
65150 empP16%=&F
65160 empP24%=&F
65170 empP32%=&F
65180 empPS%=&F
65190 empPF%=&F
65200 empP8AI%=&F
65210 empP16AI%=&F
65220 empP24AI%=&F
65230 empP32AI%=&F
65240 empPSAI%=&F
65250 empPFAI%=&F
65260 empCMB%=&F
65270 empXMB%=&F
65280 empZMB%=&F
65290 emBase%=&40000
65300 FOR address%=&F110 TO &F2C4
65310   READ assembly%
65315   PRINT " ";~assembly%;
65320   ?address%=assembly%
65330 NEXT address%
65340 PRINT: PRINT


65400 DATA &5B, &11, &00, &00, &00, &5B, &21, &00, &00, &05, &5B, &01, &00, &00, &07, &5B
65401 DATA &ED, &1F, &5B, &0B, &20, &F9, &C9, &5B, &CD, &7A, &F2, &04, &5B, &DD, &2A, &00
65402 DATA &F1, &04, &49, &DD, &6E, &00, &AF, &67, &D9, &AF, &6F, &67, &4F, &C9, &5B, &CD
65403 DATA &75, &F2, &04, &5B, &DD, &2A, &00, &F1, &04, &49, &DD, &6E, &00, &49, &DD, &66
65404 DATA &01, &AF, &D9, &AF, &6F, &67, &4F, &C9, &5B, &CD, &70, &F2, &04, &5B, &DD, &2A
65405 DATA &00, &F1, &04, &49, &DD, &6E, &00, &49, &DD, &66, &01, &AF, &D9, &AF, &DD, &6E
65406 DATA &02, &67, &4F, &C9, &5B, &CD, &6B, &F2, &04, &5B, &DD, &2A, &00, &F1, &04, &49
65407 DATA &DD, &6E, &00, &49, &DD, &66, &01, &AF, &D9, &AF, &DD, &6E, &02, &DD, &66, &03
65408 DATA &4F, &C9, &5B, &CD, &A6, &F2, &04, &5B, &DD, &2A, &00, &F1, &04, &5B, &FD, &21
65409 DATA &00, &F0, &04, &06, &00, &49, &DD, &7E, &00, &49, &FD, &77, &00, &FE, &0D, &28
65410 DATA &09, &49, &DD, &23, &49, &FD, &23, &05, &20, &EB, &C9, &5B, &CD, &A8, &F2, &04
65411 DATA &C9, &5B, &CD, &B9, &F2, &04, &5B, &DD, &21, &00, &F0, &04, &5B, &FD, &2A, &04
65412 DATA &F1, &04, &49, &DD, &7E, &00, &5B, &FD, &77, &00, &C9, &5B, &CD, &B4, &F2, &04
65413 DATA &5B, &DD, &21, &00, &F0, &04, &5B, &FD, &2A, &04, &F1, &04, &49, &DD, &7E, &00
65414 DATA &5B, &FD, &77, &00, &49, &DD, &7E, &01, &49, &FD, &77, &01, &C9, &5B, &CD, &AF
65415 DATA &F2, &04, &5B, &DD, &21, &00, &F0, &04, &5B, &FD, &2A, &04, &F1, &04, &5B, &DD
65416 DATA &17, &00, &5B, &FD, &1F, &00, &C9, &5B, &CD, &AA, &F2, &04, &5B, &DD, &21, &00
65417 DATA &F0, &04, &5B, &FD, &2A, &04, &F1, &04, &5B, &DD, &17, &00, &5B, &FD, &1F, &00
65418 DATA &49, &DD, &7E, &03, &49, &FD, &77, &03, &C9, &5B, &CD, &C1, &F2, &04, &5B, &DD
65419 DATA &21, &00, &F0, &04, &5B, &FD, &2A, &04, &F1, &04, &06, &00, &49, &DD, &7E, &00
65420 DATA &49, &FD, &77, &00, &FE, &0D, &28, &09, &49, &DD, &23, &49, &FD, &23, &05, &20
65421 DATA &EB, &C9, &5B, &CD, &C3, &F2, &04, &C9, &C9, &C9, &C9, &5B, &CD, &7A, &F2, &04
65422 DATA &5B, &CD, &7A, &F2, &04, &5B, &CD, &7A, &F2, &04, &5B, &DD, &21, &00, &F1, &04
65423 DATA &5B, &3A, &08, &F1, &04, &DD, &86, &00, &5B, &DD, &77, &00, &5B, &3A, &09, &F1
65424 DATA &04, &DD, &8E, &01, &5B, &DD, &77, &01, &5B, &3A, &0A, &F1, &04, &DD, &8E, &02
65425 DATA &5B, &DD, &77, &02, &49, &C9, &49, &C9, &49, &C9, &5B, &CD, &B9, &F2, &04, &5B
65426 DATA &CD, &B9, &F2, &04, &5B, &CD, &B9, &F2, &04, &5B, &DD, &21, &04, &F1, &04, &18
65427 DATA &BF, &49, &C9, &49, &C9

65499 ENDPROC
