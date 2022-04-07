* Standard prelude:
0: LD 6,0(0)	load up with maxaddr
1: LDA 5,0(6)	copy gp to fp
2: ST 0,0(0)	clear content at loc 0
* Jump around i/o routines here
* code for input routine
4: ST 0,-1(5)	store return
5: IN 0,0,0	input
6: LD 7,-1(5)	return to caller
* code for output routine
7: ST 0,-1(5)	store return
8: LD 0,-2(5)	load output value
9: OUT 0,0,0	input
10: LD 7,-1(5)	return to caller
3: LDA 7,7(7)	jump around i/o code
* End of standard prelude.
* processing function: main
12: ST 0,-1(5)	save return address
* looking up id: x
13: LDA 0,0(6)	load id address
* <- id
14: ST 0,-3(5)	op: push left
15: LDC 0,6(0)	load const(6) <- constant
16: ST 0,-4(5)	load const(6) <- constant
17: LD 0,-3(5)	load address of lhs into ac
18: LD 1,-4(5)	load rhs constant into ac1
19: ST 1,0(0)	storing rhs constant into address of lhs
20: ST 1,0(6)	storing rhs constant into offet of assignExp
* looking up id: y
21: LDA 0,-1(6)	load id address
* <- id
22: ST 0,-3(5)	op: push left
23: LDC 0,3(0)	load const(3) <- constant
24: ST 0,-4(5)	load const(3) <- constant
25: LD 0,-3(5)	load address of lhs into ac
26: LD 1,-4(5)	load rhs constant into ac1
27: ST 1,0(0)	storing rhs constant into address of lhs
28: ST 1,-1(6)	storing rhs constant into offet of assignExp
29: LD 0,0(6)	load value of var into AC
30: ST 0,-4(5)	Storing value of arg 1 into (-2)fp
31: ST 5,-2(5)	* store current fp
32: LDA 5,-2(5)	* push new frame
33: LDA 0,1(7)	* save return in ac
34: LDA 7,-28(7)	* relative jump to function entry
35: LD 5,0(5)	 * pop current frame
36: LDC 0,5(0)	load const(5) <- constant
37: ST 0,-2(5)	load const(5) <- constant
38: ST 0,-4(5)	Storing value of arg 1 into (-2)fp
39: ST 5,-2(5)	* store current fp
40: LDA 5,-2(5)	* push new frame
41: LDA 0,1(7)	* save return in ac
42: LDA 7,-36(7)	* relative jump to function entry
43: LD 5,0(5)	 * pop current frame
44: LD 7,-1(5)	return back to the caller
11: LDA 7,33(7)	jump forward to finale
45: ST 5,-2(5)	push ofp
46: LDA 5,-2(5)	push frame
47: LDA 0,1(7)	load ac with ret ptr
48: LDA 7,-37(7)	jump to main loc
49: LD 5,0(5)	pop frame
50: HALT 0,0,0	
