10 REM emtests.bas
20 HIMEM=&F000
30 PROC_empInit
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
75 !emdDA%=&4F003: !emdV16%=&5566: CALL empP16%: PRINT "04b: ";~USR(emfG16%): PROC_wait

80 !emdSA%=&4F004: !&F004=&162738: PRINT "05a: ";~USR(emfG24%): PROC_wait
85 !emdDA%=&4F004: !emdV24%=&8899AA: CALL empP24%: PRINT "05b: ";~USR(emfG24%): PROC_wait

90 !emdSA%=&4F005: !&F005=&A6B7D3C5: PRINT "06a: ";~USR(emfG32%): PROC_wait
95 !emdDA%=&4F005: !emdV32%=&BBCCDDEE: CALL empP32%: PRINT "06b: ";~USR(emfG32%): PROC_wait

100 !emdSA%=&4F036: $&F036="Test string!": CALL empGS%: PRINT "07a: ";$emdVS%: PROC_wait
105 !emdDA%=&4F036: $emdVS%="[Cool-text]": CALL empPS%: PRINT "07b: ";$&F036: PROC_wait

110 !emdSA%=&4F000: ?&F001=&6C: !emdAI% = 1: PRINT "08a: ";~USR(emfG8AI%);" ";~USR(emdSA%): PROC_wait
115 !emdDA%=&4F000: ?emdV8%=&7D: !emdAI% = 1: CALL empP8AI%: PRINT "08b: ";~USR(emdDA%): PROC_wait

999 END
1000 DEF PROC_wait
1010 FOR I=0 TO 10000:NEXT I
1020 ENDPROC
65000 DEF PROC_empInit

65010 emdAI%=&0F108
65011 emdDA%=&0F104
65012 emdIS%=&0F10C
65013 emdRC%=&0F110
65014 emdSA%=&0F100
65015 emdV16%=&0F000
65016 emdV24%=&0F000
65017 emdV32%=&0F000
65018 emdV8%=&0F000
65019 emdVS%=&0F000
65020 emfG16%=&0F147
65021 emfG16AI%=&0F142
65022 emfG24%=&0F161
65023 emfG24AI%=&0F15C
65024 emfG32%=&0F17E
65025 emfG32AI%=&0F179
65026 emfG8%=&0F130
65027 emfG8AI%=&0F12B
65028 emfGF%=&0F1C7
65029 emfGFAI%=&0F1C2
65030 empCMB%=&0F26F
65031 empGS%=&0F19E
65032 empGSAI%=&0F199
65033 empI%=&0F114
65034 empP16%=&0F1E7
65035 empP16AI%=&0F1E2
65036 empP24%=&0F209
65037 empP24AI%=&0F204
65038 empP32%=&0F223
65039 empP32AI%=&0F21E
65040 empP8%=&0F1CD
65041 empP8AI%=&0F1C8
65042 empPF%=&0F26E
65043 empPFAI%=&0F269
65044 empPS%=&0F245
65045 empPSAI%=&0F240
65046 empXMB%=&0F270
65047 empZMB%=&0F271

65290 emBase%=&40000
65300 FOR address%=&F114 TO &F339
65310   READ assembly%
65320   ?address%=assembly%
65330 NEXT address%

65400 DATA &5B, &11, &00, &00, &00, &5B, &21, &00, &00, &05, &5B, &01, &00, &00, &07, &5B
65401 DATA &ED, &1F, &5B, &0B, &20, &F9, &C9, &5B, &CD, &A2, &F2, &04, &5B, &DD, &2A, &00
65402 DATA &F1, &04, &5B, &DD, &6E, &00, &AF, &67, &D9, &AF, &6F, &67, &4F, &C9, &5B, &CD
65403 DATA &9D, &F2, &04, &5B, &DD, &2A, &00, &F1, &04, &5B, &DD, &6E, &00, &5B, &DD, &66
65404 DATA &01, &AF, &D9, &AF, &6F, &67, &4F, &C9, &5B, &CD, &98, &F2, &04, &5B, &DD, &2A
65405 DATA &00, &F1, &04, &5B, &DD, &6E, &00, &5B, &DD, &66, &01, &AF, &D9, &AF, &5B, &DD
65406 DATA &6E, &02, &67, &4F, &C9, &5B, &CD, &93, &F2, &04, &5B, &DD, &2A, &00, &F1, &04
65407 DATA &5B, &DD, &6E, &00, &5B, &DD, &66, &01, &AF, &D9, &AF, &5B, &DD, &6E, &02, &5B
65408 DATA &DD, &66, &03, &4F, &C9, &5B, &CD, &D9, &F2, &04, &5B, &DD, &2A, &00, &F1, &04
65409 DATA &5B, &FD, &21, &00, &F0, &04, &06, &00, &5B, &DD, &7E, &00, &5B, &FD, &77, &00
65410 DATA &FE, &0D, &28, &09, &49, &DD, &23, &49, &FD, &23, &05, &20, &EB, &C9, &5B, &CD
65411 DATA &8E, &F2, &04, &C9, &5B, &CD, &86, &F2, &04, &5B, &DD, &21, &00, &F0, &04, &5B
65412 DATA &FD, &2A, &04, &F1, &04, &5B, &DD, &7E, &00, &5B, &FD, &77, &00, &C9, &5B, &CD
65413 DATA &81, &F2, &04, &5B, &DD, &21, &00, &F0, &04, &5B, &FD, &2A, &04, &F1, &04, &5B
65414 DATA &DD, &7E, &00, &5B, &FD, &77, &00, &5B, &DD, &7E, &01, &5B, &FD, &77, &01, &C9
65415 DATA &5B, &CD, &7C, &F2, &04, &5B, &DD, &21, &00, &F0, &04, &5B, &FD, &2A, &04, &F1
65416 DATA &04, &5B, &DD, &17, &00, &5B, &FD, &1F, &00, &C9, &5B, &CD, &77, &F2, &04, &5B
65417 DATA &DD, &21, &00, &F0, &04, &5B, &FD, &2A, &04, &F1, &04, &5B, &DD, &17, &00, &5B
65418 DATA &FD, &1F, &00, &5B, &DD, &7E, &03, &5B, &FD, &77, &03, &C9, &5B, &CD, &D1, &F2
65419 DATA &04, &5B, &DD, &21, &00, &F0, &04, &5B, &FD, &2A, &04, &F1, &04, &06, &00, &5B
65420 DATA &DD, &7E, &00, &5B, &FD, &77, &00, &FE, &0D, &28, &09, &49, &DD, &23, &49, &FD
65421 DATA &23, &05, &20, &EB, &C9, &5B, &CD, &72, &F2, &04, &C9, &C9, &C9, &C9, &5B, &CD
65422 DATA &86, &F2, &04, &5B, &CD, &86, &F2, &04, &5B, &CD, &86, &F2, &04, &5B, &CD, &86
65423 DATA &F2, &04, &5B, &DD, &21, &04, &F1, &04, &18, &1A, &5B, &CD, &A2, &F2, &04, &5B
65424 DATA &CD, &A2, &F2, &04, &5B, &CD, &A2, &F2, &04, &5B, &CD, &A2, &F2, &04, &5B, &DD
65425 DATA &21, &00, &F1, &04, &5B, &3A, &08, &F1, &04, &5B, &DD, &86, &00, &5B, &DD, &77
65426 DATA &00, &5B, &3A, &09, &F1, &04, &5B, &DD, &8E, &01, &5B, &DD, &77, &01, &5B, &3A
65427 DATA &0A, &F1, &04, &5B, &DD, &8E, &02, &5B, &DD, &77, &02, &49, &C9, &5B, &DD, &21
65428 DATA &04, &F1, &04, &18, &06, &5B, &DD, &21, &00, &F1, &04, &DD, &E5, &5B, &DD, &21
65429 DATA &08, &F1, &04, &5B, &FD, &21, &0C, &F1, &04, &5B, &DD, &46, &01, &5B, &FD, &4E
65430 DATA &01, &ED, &4C, &D9, &5B, &DD, &46, &00, &5B, &FD, &4E, &00, &ED, &4C, &5B, &DD
65431 DATA &56, &01, &5B, &FD, &5E, &00, &ED, &5C, &5B, &DD, &66, &00, &5B, &FD, &6E, &01
65432 DATA &ED, &6C, &DD, &E1, &79, &5B, &DD, &86, &00, &5B, &DD, &77, &00, &78, &8B, &8D
65433 DATA &5B, &DD, &8E, &01, &5B, &DD, &77, &01, &7A, &8C, &D9, &89, &5B, &DD, &8E, &02
65434 DATA &5B, &DD, &77, &02, &49, &C9

65499 ENDPROC
