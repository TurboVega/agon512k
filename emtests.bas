10 REM emtests.bas
20 HIMEM=&FB00
30 PROC_empInit
35 REM Using addresses in range &4FB00 to &4FBFF, just so we can use
36 REM indirection to write/read test data in memory. Note indirection
37 REM must use addresses in range &0F000 to &0F0FF, to correspond.
38 REM NOTE: Some values are assigned to extended memory variables here,
39 REM       just to be overwritten, to prove that the "get" functions work.

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

130 !emdSA%=&4FB00: !&FB06=&2425: !emdAI%=3: PRINT "10a: ";~USR(emfG16AI%);" ";~!emdSA%: PROC_wait
135 !emdDA%=&4FB00: !emdV16%=&2627: !emdAI%=4: CALL empP16AI%: PRINT "10b: ";~!emdDA%: PROC_wait
137 !emdSA%=&4FB00: !emdAI%=4: PRINT "10c: ";~USR(emfG16AI%);" ";~!emdSA%: PROC_wait

140 !emdSA%=&4FB00: !&FB30=&38393A: !emdAI%=16: PRINT "11a: ";~USR(emfG24AI%);" ";~!emdSA%: PROC_wait
145 !emdDA%=&4FB00: !emdV24%=&3C3D3E: !emdAI%=32: CALL empP24AI%: PRINT "11b: ";~!emdDA%: PROC_wait
147 !emdSA%=&4FB00: !emdAI%=32: PRINT "11c: ";~USR(emfG24AI%);" ";~!emdSA%: PROC_wait

150 !emdSA%=&4FB00: !&FB0C=&11223344: !emdAI%=3: PRINT "12a: ";~USR(emfG32AI%);" ";~!emdSA%: PROC_wait
155 !emdDA%=&4FB00: !emdV32%=&55667788: !emdAI%=5: CALL empP32AI%: PRINT "12b: ";~!emdDA%: PROC_wait
157 !emdSA%=&4FB00: !emdAI%=5: PRINT "12c: ";~USR(emfG32AI%);" ";~!emdSA%: PROC_wait

160 myfloat=665.53599: !emdDA%=&4FB00: !emdAI%=7: CALL empPFAI%,myfloat: PRINT "13a: ";myfloat: PROC_wait
165 myfloat=-0.2: !emdSA%=&4FB00: !emdAI%=7: CALL empGFAI%,myfloat: PRINT "13b: ";myfloat: PROC_wait

170 !emdSA%=&4FB20: $&FB50="Text.": !emdAI%=3: !emdIS%=16: CALL empGSAI%: PRINT "14a: ";$emdVS%: PROC_wait
175 !emdDA%=&4FB20: $emdVS%="(more)": !emdAI%=3: !emdIS%=16: CALL empPSAI%: PRINT "14b: ";$&FB50: PROC_wait

180 myfloat=98765.432: !emdDA%=&8FF00: CALL empPF%,myfloat: PRINT "15a: ";myfloat: PROC_wait
182 myfloat=5.6: !emdSA%=&8FF00: CALL empGF%,myfloat: PRINT "15b: ";myfloat: PROC_wait
184 myfloat=2.6: CALL empI%: !emdSA%=&8FF00: CALL empGF%,myfloat: PRINT "15c: ";myfloat;" ";~!emdDA%: PROC_wait

190 myfloat=-39.75: !emdDA%=&8FF00: CALL empPF%,myfloat: PRINT "16a: ";myfloat: PROC_wait
192 myfloat=7.8: !emdSA%=&8FF00: CALL empGF%,myfloat: PRINT "16b: ";myfloat: PROC_wait
194 !emdSA%=&8FF00: !emdDA%=&70025: !emdRC%=5: CALL empCMBI%: PRINT "16c: ";~!emdDA%: PROC_wait
196 myfloat=9.0: !emdSA%=&70025: CALL empGF%,myfloat: PRINT "16d: ";myfloat: PROC_wait

200 myfloat=11.111: !emdDA%=&60000: CALL empPF%,myfloat: PRINT "17a: ";myfloat: PROC_wait
202 myfloat=22.222: !emdSA%=&60000: CALL empGF%,myfloat: PRINT "17b: ";myfloat: PROC_wait
204 myfloat=33.333: !emdDA%=&68000: CALL empPF%,myfloat: PRINT "17c: ";myfloat: PROC_wait
206 myfloat=44.444: !emdSA%=&68000: CALL empGF%,myfloat: PRINT "17d: ";myfloat: PROC_wait
209 !emdSA%=&60000: !emdDA%=&68000: !emdRC%=5: CALL empXMB%: PRINT "17e: ";~!emdSA%;" ";~!emdDA%: PROC_wait
211 myfloat=55.555: !emdSA%=&60000: CALL empGF%,myfloat: PRINT "17f: ";myfloat: PROC_wait
212 myfloat=66.666: !emdSA%=&68000: CALL empGF%,myfloat: PRINT "17g: ";myfloat: PROC_wait

220 !emdDA%=&68000: !emdRC%=5: CALL empZMB%: PRINT "18a: ";~!emdDA%: PROC_wait
221 myfloat=55.555: !emdSA%=&68000: CALL empGF%,myfloat: PRINT "18b: ";myfloat: PROC_wait

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
65020 emfG16%=&FC52
65021 emfG16AI%=&FC4D
65022 emfG24%=&FC6C
65023 emfG24AI%=&FC67
65024 emfG32%=&FC89
65025 emfG32AI%=&FC84
65026 emfG8%=&FC3B
65027 emfG8AI%=&FC36
65028 empCMBD%=&FDE7
65029 empCMBI%=&FDD2
65030 empGF%=&FCD6
65031 empGFAI%=&FCCD
65032 empGS%=&FCA9
65033 empGSAI%=&FCA4
65034 empI%=&FC14
65035 empP16%=&FD1E
65036 empP16AI%=&FD19
65037 empP24%=&FD40
65038 empP24AI%=&FD3B
65039 empP32%=&FD5A
65040 empP32AI%=&FD55
65041 empP8%=&FD04
65042 empP8AI%=&FCFF
65043 empPF%=&FDA9
65044 empPFAI%=&FDA0
65045 empPS%=&FD7C
65046 empPSAI%=&FD77
65047 empXMB%=&FE04
65048 empZMB%=&FE4B

65290 emBase%=&40000
65300 FOR address%=&FC14 TO &FF46
65310   READ assembly%
65320   ?address%=assembly%
65330 NEXT address%

65400 DATA &AF, &5B, &DD, &21, &00, &00, &05, &06, &06, &57, &5F, &5B, &DD, &77, &00, &49
65401 DATA &DD, &23, &1D, &20, &F6, &15, &20, &F3, &05, &20, &F0, &5B, &DD, &22, &04, &FC
65402 DATA &04, &C9, &5B, &CD, &AF, &FE, &04, &5B, &DD, &2A, &00, &FC, &04, &5B, &DD, &6E
65403 DATA &00, &AF, &67, &D9, &AF, &6F, &67, &4F, &C9, &5B, &CD, &AA, &FE, &04, &5B, &DD
65404 DATA &2A, &00, &FC, &04, &5B, &DD, &6E, &00, &5B, &DD, &66, &01, &AF, &D9, &AF, &6F
65405 DATA &67, &4F, &C9, &5B, &CD, &A5, &FE, &04, &5B, &DD, &2A, &00, &FC, &04, &5B, &DD
65406 DATA &6E, &00, &5B, &DD, &66, &01, &AF, &D9, &AF, &5B, &DD, &6E, &02, &67, &4F, &C9
65407 DATA &5B, &CD, &A0, &FE, &04, &5B, &DD, &2A, &00, &FC, &04, &5B, &DD, &6E, &00, &5B
65408 DATA &DD, &66, &01, &AF, &D9, &AF, &5B, &DD, &6E, &02, &5B, &DD, &66, &03, &4F, &C9
65409 DATA &5B, &CD, &E6, &FE, &04, &5B, &DD, &2A, &00, &FC, &04, &5B, &FD, &21, &00, &FB
65410 DATA &04, &06, &00, &5B, &DD, &7E, &00, &5B, &FD, &77, &00, &FE, &0D, &28, &09, &49
65411 DATA &DD, &23, &49, &FD, &23, &05, &20, &EB, &C9, &DD, &E5, &5B, &CD, &9B, &FE, &04
65412 DATA &DD, &E1, &DD, &7E, &00, &FE, &01, &20, &21, &DD, &7E, &01, &FE, &05, &20, &1A
65413 DATA &DD, &31, &02, &5B, &DD, &2A, &00, &FC, &04, &06, &05, &5B, &DD, &7E, &00, &FD
65414 DATA &77, &00, &49, &DD, &23, &FD, &23, &05, &20, &F1, &C9, &5B, &CD, &93, &FE, &04
65415 DATA &5B, &DD, &21, &00, &FB, &04, &5B, &FD, &2A, &04, &FC, &04, &5B, &DD, &7E, &00
65416 DATA &5B, &FD, &77, &00, &C9, &5B, &CD, &8E, &FE, &04, &5B, &DD, &21, &00, &FB, &04
65417 DATA &5B, &FD, &2A, &04, &FC, &04, &5B, &DD, &7E, &00, &5B, &FD, &77, &00, &5B, &DD
65418 DATA &7E, &01, &5B, &FD, &77, &01, &C9, &5B, &CD, &89, &FE, &04, &5B, &DD, &21, &00
65419 DATA &FB, &04, &5B, &FD, &2A, &04, &FC, &04, &5B, &DD, &17, &00, &5B, &FD, &1F, &00
65420 DATA &C9, &5B, &CD, &84, &FE, &04, &5B, &DD, &21, &00, &FB, &04, &5B, &FD, &2A, &04
65421 DATA &FC, &04, &5B, &DD, &17, &00, &5B, &FD, &1F, &00, &5B, &DD, &7E, &03, &5B, &FD
65422 DATA &77, &03, &C9, &5B, &CD, &DE, &FE, &04, &5B, &DD, &21, &00, &FB, &04, &5B, &FD
65423 DATA &2A, &04, &FC, &04, &06, &00, &5B, &DD, &7E, &00, &5B, &FD, &77, &00, &FE, &0D
65424 DATA &28, &09, &49, &DD, &23, &49, &FD, &23, &05, &20, &EB, &C9, &DD, &E5, &5B, &CD
65425 DATA &7F, &FE, &04, &DD, &E1, &DD, &7E, &00, &FE, &01, &20, &21, &DD, &7E, &01, &FE
65426 DATA &05, &20, &1A, &DD, &37, &02, &5B, &FD, &2A, &04, &FC, &04, &06, &05, &DD, &7E
65427 DATA &00, &5B, &FD, &77, &00, &DD, &23, &49, &FD, &23, &05, &20, &F1, &C9, &5B, &2A
65428 DATA &00, &FC, &04, &5B, &ED, &5B, &04, &FC, &04, &5B, &ED, &4B, &10, &FC, &04, &5B
65429 DATA &ED, &B0, &C9, &5B, &2A, &00, &FC, &04, &5B, &ED, &5B, &04, &FC, &04, &5B, &ED
65430 DATA &4B, &10, &FC, &04, &49, &2B, &49, &1B, &5B, &ED, &B8, &49, &23, &49, &13, &C9
65431 DATA &5B, &DD, &2A, &00, &FC, &04, &5B, &2A, &04, &FC, &04, &5B, &FD, &21, &10, &FC
65432 DATA &04, &FD, &46, &02, &FD, &56, &01, &FD, &5E, &00, &5B, &DD, &4E, &00, &5B, &7E
65433 DATA &5B, &71, &5B, &DD, &77, &00, &49, &DD, &23, &49, &23, &7B, &D6, &01, &5F, &7A
65434 DATA &DE, &00, &57, &78, &DE, &00, &47, &B2, &B3, &20, &DF, &5B, &DD, &22, &00, &FC
65435 DATA &04, &5B, &22, &04, &FC, &04, &C9, &5B, &DD, &2A, &04, &FC, &04, &5B, &FD, &21
65436 DATA &10, &FC, &04, &FD, &46, &02, &FD, &56, &01, &FD, &5E, &00, &AF, &5B, &DD, &77
65437 DATA &00, &49, &DD, &23, &7B, &D6, &01, &5F, &7A, &DE, &00, &57, &78, &DE, &00, &47
65438 DATA &B2, &B3, &20, &E8, &5B, &DD, &22, &04, &FC, &04, &C9, &5B, &CD, &93, &FE, &04
65439 DATA &5B, &CD, &93, &FE, &04, &5B, &CD, &93, &FE, &04, &5B, &CD, &93, &FE, &04, &5B
65440 DATA &DD, &21, &04, &FC, &04, &18, &1A, &5B, &CD, &AF, &FE, &04, &5B, &CD, &AF, &FE
65441 DATA &04, &5B, &CD, &AF, &FE, &04, &5B, &CD, &AF, &FE, &04, &5B, &DD, &21, &00, &FC
65442 DATA &04, &5B, &3A, &08, &FC, &04, &5B, &DD, &86, &00, &5B, &DD, &77, &00, &5B, &3A
65443 DATA &09, &FC, &04, &5B, &DD, &8E, &01, &5B, &DD, &77, &01, &5B, &3A, &0A, &FC, &04
65444 DATA &5B, &DD, &8E, &02, &5B, &DD, &77, &02, &49, &C9, &5B, &DD, &21, &04, &FC, &04
65445 DATA &18, &06, &5B, &DD, &21, &00, &FC, &04, &DD, &E5, &5B, &DD, &21, &08, &FC, &04
65446 DATA &5B, &FD, &21, &0C, &FC, &04, &5B, &DD, &46, &01, &5B, &FD, &4E, &01, &ED, &4C
65447 DATA &D9, &5B, &DD, &46, &00, &5B, &FD, &4E, &00, &ED, &4C, &5B, &DD, &56, &01, &5B
65448 DATA &FD, &5E, &00, &ED, &5C, &5B, &DD, &66, &00, &5B, &FD, &6E, &01, &ED, &6C, &DD
65449 DATA &E1, &79, &5B, &DD, &86, &00, &5B, &DD, &77, &00, &78, &8B, &8D, &5B, &DD, &8E
65450 DATA &01, &5B, &DD, &77, &01, &7A, &8C, &D9, &89, &5B, &DD, &8E, &02, &5B, &DD, &77
65451 DATA &02, &49, &C9

65499 ENDPROC
