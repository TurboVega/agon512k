10 REM emtests.bas
20 HIMEM=&FB00
30 PROC_empInit
35 REM Using addresses in range &4FB00 to &4FBFF, just so we can use
36 REM indirection to write/read test data in memory. Note indirection
37 REM must use addresses in range &0F000 to &0F0FF, to correspond.

40 !emdSA%=&4FB00: ?&FB00=&5A: PRINT "01a: ";~USR(emfG8%): PROC_wait
45 !emdDA%=&4FB00: ?emdV8%=&11: CALL empP8%: PRINT "01b: ";~USR(emfG8%): PROC_wait

50 !emdSA%=&4FB01: ?&FB01=&A5: PRINT "02a: ";~USR(emfG8%): PROC_wait
55 !emdDA%=&4FB01: ?emdV8%=&22: CALL empP8%: PRINT "02b: ";~USR(emfG8%): PROC_wait

60 !emdSA%=&4FB02: !&FB02=&6789: PRINT "03a: ";~USR(emfG16%): PROC_wait
65 !emdDA%=&4FB02: !emdV16%=&3344: CALL empP16%: PRINT "03b: ";~USR(emfG16%): PROC_wait

70 !emdSA%=&4FB03: !&FB03=&B3C2: PRINT "04a: ";~USR(emfG16%): PROC_wait
75 !emdDA%=&4FB03: !emdV16%=&5566: CALL empP16%: PRINT "04b: ";~USR(emfG16%): PROC_wait

80 !emdSA%=&4FB04: !&FB04=&162738: PRINT "05a: ";~USR(emfG24%): PROC_wait
85 !emdDA%=&4FB04: !emdV24%=&8899AA: CALL empP24%: PRINT "05b: ";~USR(emfG24%): PROC_wait

90 !emdSA%=&4FB05: !&FB05=&A6B7D3C5: PRINT "06a: ";~USR(emfG32%): PROC_wait
95 !emdDA%=&4FB05: !emdV32%=&BBCCDDEE: CALL empP32%: PRINT "06b: ";~USR(emfG32%): PROC_wait

100 !emdSA%=&4FB36: $&FB36="Test string!": CALL empGS%: PRINT "07a: ";$emdVS%: PROC_wait
105 !emdDA%=&4FB36: $emdVS%="[Cool-text]": CALL empPS%: PRINT "07b: ";$&FB36: PROC_wait

110 myfloat=-66.778899: !emdDA%=&4FB40: CALL empPF%,myfloat: PRINT "08a: ";myfloat: PROC_wait
115 myfloat=3.1415926: !emdSA%=&4FB40: CALL empGF%,myfloat: PRINT "08b: ";myfloat: PROC_wait

120 !emdSA%=&4FB00: ?&FB01=&6C: !emdAI%=1: PRINT "09a: ";~USR(emfG8AI%);" ";~!emdSA%: PROC_wait
125 !emdDA%=&4FB00: ?emdV8%=&7D: !emdAI%=1: CALL empP8AI%: PRINT "09b: ";~!emdDA%: PROC_wait
127 !emdSA%=&4FB00: !emdAI%=1: PRINT "09c: ";~USR(emfG8AI%);" ";~!emdSA%: PROC_wait

999 END
1000 DEF PROC_wait
1010 FOR I=0 TO 10000:NEXT I
1020 ENDPROC
65000 DEF PROC_empInit

65010 emdAI%=&FC08
65011 emdDA%=&FC04
65012 emdIS%=&FC0C
65013 emdRC%=&FC10
65014 emdSA%=&FC00
65015 emdV16%=&FB00
65016 emdV24%=&FB00
65017 emdV32%=&FB00
65018 emdV8%=&FB00
65019 emdVS%=&FB00
65020 emfG16%=&FC47
65021 emfG16AI%=&FC42
65022 emfG24%=&FC61
65023 emfG24AI%=&FC5C
65024 emfG32%=&FC7E
65025 emfG32AI%=&FC79
65026 emfG8%=&FC30
65027 emfG8AI%=&FC2B
65028 empCMBD%=&FDDC
65029 empCMBI%=&FDC7
65030 empGF%=&FCCB
65031 empGFAI%=&FCC2
65032 empGS%=&FC9E
65033 empGSAI%=&FC99
65034 empI%=&FC14
65035 empP16%=&FD13
65036 empP16AI%=&FD0E
65037 empP24%=&FD35
65038 empP24AI%=&FD30
65039 empP32%=&FD4F
65040 empP32AI%=&FD4A
65041 empP8%=&FCF9
65042 empP8AI%=&FCF4
65043 empPF%=&FD9E
65044 empPFAI%=&FD95
65045 empPS%=&FD71
65046 empPSAI%=&FD6C
65047 empXMB%=&FDF5
65048 empZMB%=&FE22

65290 emBase%=&40000
65300 FOR address%=&FC14 TO &FF05
65310   READ assembly%
65320   ?address%=assembly%
65330 NEXT address%

65400 DATA &5B, &11, &00, &00, &00, &5B, &21, &00, &00, &05, &5B, &01, &00, &00, &07, &5B
65401 DATA &ED, &1F, &5B, &0B, &20, &F9, &C9, &5B, &CD, &6E, &FE, &04, &5B, &DD, &2A, &00
65402 DATA &FC, &04, &5B, &DD, &6E, &00, &AF, &67, &D9, &AF, &6F, &67, &4F, &C9, &5B, &CD
65403 DATA &69, &FE, &04, &5B, &DD, &2A, &00, &FC, &04, &5B, &DD, &6E, &00, &5B, &DD, &66
65404 DATA &01, &AF, &D9, &AF, &6F, &67, &4F, &C9, &5B, &CD, &64, &FE, &04, &5B, &DD, &2A
65405 DATA &00, &FC, &04, &5B, &DD, &6E, &00, &5B, &DD, &66, &01, &AF, &D9, &AF, &5B, &DD
65406 DATA &6E, &02, &67, &4F, &C9, &5B, &CD, &5F, &FE, &04, &5B, &DD, &2A, &00, &FC, &04
65407 DATA &5B, &DD, &6E, &00, &5B, &DD, &66, &01, &AF, &D9, &AF, &5B, &DD, &6E, &02, &5B
65408 DATA &DD, &66, &03, &4F, &C9, &5B, &CD, &A5, &FE, &04, &5B, &DD, &2A, &00, &FC, &04
65409 DATA &5B, &FD, &21, &00, &FB, &04, &06, &00, &5B, &DD, &7E, &00, &5B, &FD, &77, &00
65410 DATA &FE, &0D, &28, &09, &49, &DD, &23, &49, &FD, &23, &05, &20, &EB, &C9, &DD, &E5
65411 DATA &5B, &CD, &5A, &FE, &04, &DD, &E1, &DD, &7E, &00, &FE, &01, &20, &21, &DD, &7E
65412 DATA &01, &FE, &05, &20, &1A, &DD, &31, &02, &5B, &DD, &2A, &00, &FC, &04, &06, &05
65413 DATA &5B, &DD, &7E, &00, &FD, &77, &00, &49, &DD, &23, &FD, &23, &05, &20, &F1, &C9
65414 DATA &5B, &CD, &52, &FE, &04, &5B, &DD, &21, &00, &FB, &04, &5B, &FD, &2A, &04, &FC
65415 DATA &04, &5B, &DD, &7E, &00, &5B, &FD, &77, &00, &C9, &5B, &CD, &4D, &FE, &04, &5B
65416 DATA &DD, &21, &00, &FB, &04, &5B, &FD, &2A, &04, &FC, &04, &5B, &DD, &7E, &00, &5B
65417 DATA &FD, &77, &00, &5B, &DD, &7E, &01, &5B, &FD, &77, &01, &C9, &5B, &CD, &48, &FE
65418 DATA &04, &5B, &DD, &21, &00, &FB, &04, &5B, &FD, &2A, &04, &FC, &04, &5B, &DD, &17
65419 DATA &00, &5B, &FD, &1F, &00, &C9, &5B, &CD, &43, &FE, &04, &5B, &DD, &21, &00, &FB
65420 DATA &04, &5B, &FD, &2A, &04, &FC, &04, &5B, &DD, &17, &00, &5B, &FD, &1F, &00, &5B
65421 DATA &DD, &7E, &03, &5B, &FD, &77, &03, &C9, &5B, &CD, &9D, &FE, &04, &5B, &DD, &21
65422 DATA &00, &FB, &04, &5B, &FD, &2A, &04, &FC, &04, &06, &00, &5B, &DD, &7E, &00, &5B
65423 DATA &FD, &77, &00, &FE, &0D, &28, &09, &49, &DD, &23, &49, &FD, &23, &05, &20, &EB
65424 DATA &C9, &DD, &E5, &5B, &CD, &3E, &FE, &04, &DD, &E1, &DD, &7E, &00, &FE, &01, &20
65425 DATA &21, &DD, &7E, &01, &FE, &05, &20, &1A, &DD, &37, &02, &5B, &FD, &2A, &04, &FC
65426 DATA &04, &06, &05, &DD, &7E, &00, &5B, &FD, &77, &00, &DD, &23, &49, &FD, &23, &05
65427 DATA &20, &F1, &C9, &5B, &2A, &00, &FC, &04, &5B, &ED, &5B, &04, &FC, &04, &5B, &ED
65428 DATA &4B, &10, &FC, &04, &5B, &ED, &B0, &C9, &5B, &2A, &00, &FC, &04, &5B, &ED, &5B
65429 DATA &04, &FC, &04, &5B, &ED, &4B, &10, &FC, &04, &49, &2B, &49, &1B, &5B, &ED, &B8
65430 DATA &C9, &5B, &DD, &2A, &00, &FC, &04, &5B, &FD, &2A, &04, &FC, &04, &5B, &ED, &4B
65431 DATA &10, &FC, &04, &5B, &DD, &7E, &00, &5B, &FD, &66, &00, &5B, &FD, &77, &00, &5B
65432 DATA &DD, &74, &00, &49, &DD, &23, &49, &FD, &23, &49, &0B, &20, &E6, &C9, &5B, &FD
65433 DATA &2A, &04, &FC, &04, &5B, &ED, &4B, &10, &FC, &04, &AF, &5B, &FD, &77, &00, &49
65434 DATA &DD, &23, &49, &FD, &23, &49, &0B, &20, &F2, &C9, &5B, &CD, &52, &FE, &04, &5B
65435 DATA &CD, &52, &FE, &04, &5B, &CD, &52, &FE, &04, &5B, &CD, &52, &FE, &04, &5B, &DD
65436 DATA &21, &04, &FC, &04, &18, &1A, &5B, &CD, &6E, &FE, &04, &5B, &CD, &6E, &FE, &04
65437 DATA &5B, &CD, &6E, &FE, &04, &5B, &CD, &6E, &FE, &04, &5B, &DD, &21, &00, &FC, &04
65438 DATA &5B, &3A, &08, &FC, &04, &5B, &DD, &86, &00, &5B, &DD, &77, &00, &5B, &3A, &09
65439 DATA &FC, &04, &5B, &DD, &8E, &01, &5B, &DD, &77, &01, &5B, &3A, &0A, &FC, &04, &5B
65440 DATA &DD, &8E, &02, &5B, &DD, &77, &02, &49, &C9, &5B, &DD, &21, &04, &FC, &04, &18
65441 DATA &06, &5B, &DD, &21, &00, &FC, &04, &DD, &E5, &5B, &DD, &21, &08, &FC, &04, &5B
65442 DATA &FD, &21, &0C, &FC, &04, &5B, &DD, &46, &01, &5B, &FD, &4E, &01, &ED, &4C, &D9
65443 DATA &5B, &DD, &46, &00, &5B, &FD, &4E, &00, &ED, &4C, &5B, &DD, &56, &01, &5B, &FD
65444 DATA &5E, &00, &ED, &5C, &5B, &DD, &66, &00, &5B, &FD, &6E, &01, &ED, &6C, &DD, &E1
65445 DATA &79, &5B, &DD, &86, &00, &5B, &DD, &77, &00, &78, &8B, &8D, &5B, &DD, &8E, &01
65446 DATA &5B, &DD, &77, &01, &7A, &8C, &D9, &89, &5B, &DD, &8E, &02, &5B, &DD, &77, &02
65447 DATA &49, &C9

65499 ENDPROC
