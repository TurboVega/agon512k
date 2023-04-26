10 REM emtests.bas
20 HIMEM=&F000
30 PROC_empI
35 REM Using addresses in range &4F000 to &4F0FF, just so we can use
36 REM indirection to write/read test data in memory. Note indirection
37 REM must use addresses in range &0F000 to &0F0FF, to correspond.

40 !emdSA%=&4F000: ?&F000=&5A: PRINT "01a: ";~USR(emfG8%): PROC_wait
45 !emdDA%=&4F000: ?emdV8%=&11: CALL empP8%: PRINT "01b: ";~USR(emfG8%): PROC_wait

50 !emdSA%=&4F001: ?&F001=&A5: PRINT "02a: ";~USR(emfG8%): PROC_wait
55 !emdDA%=&4F001: ?emdV8%=&22: CALL empP8%: PRINT "02b: ";~USR(emfG8%): PROC_wait

60 !emdSA%=&4F002: !&F002=&6789: PRINT "03a: ";~USR(emfG16%): PROC_wait
65 !emdDA%=&4F002: !emdV16%=&3344: CALL empP16%: PRINT "03b: ";~USR(emfG16%): PROC_wait

70 !emdSA%=&4F003: !&F003=&B3C2: PRINT "04a: ";~USR(emfG16%): PROC_wait
75 !emdDA%=&4F003: !emdV16%=5566: CALL empP16%: PRINT "04b: ";~USR(emfG16%): PROC_wait

80 !emdSA%=&4F004: !&F004=&162738: PRINT "05a: ";~USR(emfG24%): PROC_wait
85 !emdDA%=&4F004: !emdV24%=&8899AA: CALL empP24%: PRINT "05b: ";~USR(emfG24%): PROC_wait

90 !emdSA%=&4F005: !&F005=&A6B7D3C5: PRINT "06a: ";~USR(emfG32%): PROC_wait
95 !emdDA%=&4F005: !emdV32%=&BBCCDDEE: CALL empP32%: PRINT "06b: ";~USR(emfG32%): PROC_wait

100 !emdSA%=&4F006: $&F006="Test string!": CALL empGS%: PRINT "07a: ";$emdVS%: PROC_wait
105 !emdDA%=&4F006: $emdVS%="[Cool-text]": CALL empPS%: PRINT "07b: ";$&F006: PROC_wait

110 !emdSA%=&4F000: ?&F001=&6C: !emdAI% = 1: PRINT "08a: ";~USR(emfG8AI%);" ";~USR(emdSA%): PROC_wait
115 !emdDA%=&4F000: ?emdV8%=&7D: !emdAI% = 1: CALL empP8AI%: PRINT "08b: ";~USR(emdDA%): PROC_wait

999 END
1000 DEF PROC_wait
1010 FOR I=0 TO 50000:NEXT I
1020 ENDPROC
65000 DEF PROC_empI

65010 emdAI%=&F108
65011 emdDA%=&F104
65012 emdIS%=&F10C
65013 emdRC%=&F110
65014 emdSA%=&F100
65015 emdV16%=&F000
65016 emdV24%=&F000
65017 emdV32%=&F000
65018 emdV8%=&F000
65019 emdVS%=&F000
65020 emfG16%=&F143
65021 emfG16AI%=&F140
65022 emfG24%=&F15B
65023 emfG24AI%=&F158
65024 emfG32%=&F175
65025 emfG32AI%=&F172
65026 emfG8%=&F12E
65027 emfG8AI%=&F12B
65028 emfGF%=&F1B8
65029 emfGFAI%=&F1B5
65030 empCMB%=&F252
65031 empGS%=&F191
65032 empGSAI%=&F18E
65033 empI%=&F114
65034 empP16%=&F1D3
65035 empP16AI%=&F1D0
65036 empP24%=&F1F2
65037 empP24AI%=&F1EF
65038 empP32%=&F20A
65039 empP32AI%=&F207
65040 empP8%=&F1BC
65041 empP8AI%=&F1B9
65042 empPF%=&F251
65043 empPFAI%=&F24E
65044 empPS%=&F22A
65045 empPSAI%=&F227
65046 empXMB%=&F253
65047 empZMB%=&F254

65290 emBase%=&40000
65300 FOR address%=&F114 TO &F2EE
65310   READ assembly%
65315   PRINT " ";~assembly%;
65320   ?address%=assembly%
65330 NEXT address%
65340 PRINT: PRINT


65400 DATA &5B, &11, &00, &00, &00, &5B, &21, &00, &00, &05, &5B, &01, &00, &00, &07, &5B
65401 DATA &ED, &1F, &5B, &0B, &20, &F9, &C9, &CD, &75, &F2, &5B, &DD, &2A, &00, &F1, &00
65402 DATA &49, &DD, &6E, &00, &AF, &67, &D9, &AF, &6F, &67, &4F, &C9, &CD, &72, &F2, &5B
65403 DATA &DD, &2A, &00, &F1, &00, &49, &DD, &6E, &00, &49, &DD, &66, &01, &AF, &D9, &AF
65404 DATA &6F, &67, &4F, &C9, &CD, &6F, &F2, &5B, &DD, &2A, &00, &F1, &00, &49, &DD, &6E
65405 DATA &00, &49, &DD, &66, &01, &AF, &D9, &AF, &DD, &6E, &02, &67, &4F, &C9, &CD, &6C
65406 DATA &F2, &5B, &DD, &2A, &00, &F1, &00, &49, &DD, &6E, &00, &49, &DD, &66, &01, &AF
65407 DATA &D9, &AF, &DD, &6E, &02, &DD, &66, &03, &4F, &C9, &CD, &A0, &F2, &5B, &DD, &2A
65408 DATA &00, &F1, &00, &5B, &FD, &21, &00, &F0, &00, &06, &00, &49, &DD, &7E, &00, &49
65409 DATA &FD, &77, &00, &FE, &0D, &28, &09, &49, &DD, &23, &49, &FD, &23, &05, &20, &EB
65410 DATA &C9, &CD, &69, &F2, &C9, &CD, &61, &F2, &5B, &DD, &21, &00, &F0, &00, &5B, &FD
65411 DATA &2A, &04, &F1, &00, &49, &DD, &7E, &00, &FD, &77, &00, &C9, &CD, &5E, &F2, &5B
65412 DATA &DD, &21, &00, &F0, &00, &5B, &FD, &2A, &04, &F1, &00, &49, &DD, &7E, &00, &FD
65413 DATA &77, &00, &49, &DD, &7E, &01, &49, &FD, &77, &01, &C9, &CD, &5B, &F2, &5B, &DD
65414 DATA &21, &00, &F0, &00, &5B, &FD, &2A, &04, &F1, &00, &5B, &DD, &17, &00, &5B, &FD
65415 DATA &1F, &00, &C9, &CD, &58, &F2, &5B, &DD, &21, &00, &F0, &00, &5B, &FD, &2A, &04
65416 DATA &F1, &00, &5B, &DD, &17, &00, &5B, &FD, &1F, &00, &49, &DD, &7E, &03, &49, &FD
65417 DATA &77, &03, &C9, &CD, &98, &F2, &5B, &DD, &21, &00, &F0, &00, &5B, &FD, &2A, &04
65418 DATA &F1, &00, &06, &00, &49, &DD, &7E, &00, &49, &FD, &77, &00, &FE, &0D, &28, &09
65419 DATA &49, &DD, &23, &49, &FD, &23, &05, &20, &EB, &C9, &CD, &55, &F2, &C9, &C9, &C9
65420 DATA &C9, &CD, &61, &F2, &CD, &61, &F2, &CD, &61, &F2, &CD, &61, &F2, &5B, &DD, &21
65421 DATA &04, &F1, &00, &18, &12, &CD, &75, &F2, &CD, &75, &F2, &CD, &75, &F2, &CD, &75
65422 DATA &F2, &5B, &DD, &21, &00, &F1, &00, &3A, &08, &F1, &DD, &86, &00, &DD, &77, &00
65423 DATA &3A, &09, &F1, &DD, &8E, &01, &DD, &77, &01, &3A, &0A, &F1, &DD, &8E, &02, &DD
65424 DATA &77, &02, &49, &C9, &5B, &DD, &21, &04, &F1, &00, &18, &06, &5B, &DD, &21, &00
65425 DATA &F1, &00, &DD, &E5, &DD, &21, &08, &F1, &FD, &21, &0C, &F1, &DD, &46, &01, &FD
65426 DATA &4E, &01, &ED, &4C, &D9, &DD, &46, &00, &FD, &4E, &00, &ED, &4C, &DD, &56, &01
65427 DATA &FD, &5E, &00, &ED, &5C, &DD, &66, &00, &FD, &6E, &01, &ED, &6C, &DD, &E1, &79
65428 DATA &DD, &86, &00, &DD, &77, &00, &78, &8B, &8D, &DD, &8E, &01, &DD, &77, &01, &7A
65429 DATA &8C, &D9, &89, &DD, &8E, &02, &DD, &77, &02, &49, &C9

65499 ENDPROC
