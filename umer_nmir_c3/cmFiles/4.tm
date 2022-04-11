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
* processing function: count
12: ST 0,-1(5)	save return address
* -> if
* -> SimpleVar
13: LD 0,-2(5)	load value of var into AC
14: ST 0,-4(5)	 <- constant
* <- SimpleVar
15: LDC 0,0(0)	load const(0) <- constant
16: ST 0,-5(5)	load const(0) <- constant
17: LD 0,-4(5)	load lhs value into ac
18: LD 1,-5(5)	load rhs value into ac1
19: SUB 0,0,1	 sub values of ac and ac1 into ac
20: JEQ 0,2(7)	br if true
21: LDC 0,0(0)	false case
22: LDA 7,1(7)	unconditional jmp
23: LDC 0,1(0)	true case
25: LD 0,-3(5)	load return value into ac
26: LD 7,-1(5)	return back to the caller
24: JEQ 0,3(7)	jump to else
* -> CallExp
* -> SimpleVar
28: LD 0,-2(5)	load value of var into AC
29: ST 0,-5(5)	 <- constant
* <- SimpleVar
30: ST 5,-3(5)	* store current fp
31: LDA 5,-3(5)	* push new frame
32: LDA 0,1(7)	* save return in ac
33: LDA 7,-27(7)	* relative jump to output function entry
34: LD 5,0(5)	 * pop current frame
* <- CallExp
35: ST 0,-3(5)	load user input
* -> CallExp
* -> SimpleVar
36: LD 0,-2(5)	load value of var into AC
37: ST 0,-6(5)	 <- constant
* <- SimpleVar
38: LDC 0,1(0)	load const(1) <- constant
39: ST 0,-7(5)	load const(1) <- constant
40: LD 0,-6(5)	load lhs value into ac
41: LD 1,-7(5)	load rhs value into ac1
42: SUB 0,0,1	sub values of ac and ac1 into ac
43: ST 0,-5(5)	storing rhs constant into address of lhs
44: ST 5,-3(5)	* store current fp
45: LDA 5,-3(5)	* push new frame
46: LDA 0,1(7)	* save return in ac
47: LDA 7,-36(7)	* relative jump to function entry
48: LD 5,0(5)	 * pop current frame
* <- CallExp
49: ST 0,-3(5)	load user input
50: LD 0,-3(5)	load return value into ac
51: LD 7,-1(5)	return back to the caller
27: LDA 7,24(7)	unconditional jump to end
* <- if
52: LD 7,-1(5)	return back to the caller
11: LDA 7,41(7)	jump forward to finale
* processing function: main
54: ST 0,-1(5)	save return address
* -> SimpleVar
* looking up id: x
55: LDA 0,-2(5)	load id address
* <- id
56: ST 0,-4(5)	op: push left
* <- SimpleVar
* -> CallExp
57: ST 5,-5(5)	* store current fp
58: LDA 5,-5(5)	* push new frame
59: LDA 0,1(7)	* save return in ac
60: LDA 7,-57(7)	* relative jump to input function entry
61: LD 5,0(5)	 * pop current frame
* <- CallExp
62: ST 0,-5(5)	load user input
63: LD 0,-4(5)	load address of lhs into ac
64: LD 1,-5(5)	load rhs constant into ac1
65: ST 1,0(0)	storing rhs constant into address of lhs
66: ST 1,-3(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
* looking up id: x
67: LDA 0,-3(5)	load id address
* <- id
68: ST 0,-5(5)	op: push left
* <- SimpleVar
69: LDC 0,1010101010(0)	load const(1010101010) <- constant
70: ST 0,-6(5)	load const(1010101010) <- constant
71: LD 0,-5(5)	load address of lhs into ac
72: LD 1,-6(5)	load rhs constant into ac1
73: ST 1,0(0)	storing rhs constant into address of lhs
74: ST 1,-4(5)	storing rhs constant into offet of assignExp
* -> CallExp
* -> SimpleVar
75: LD 0,-3(5)	load value of var into AC
76: ST 0,-6(5)	 <- constant
* <- SimpleVar
77: ST 5,-4(5)	* store current fp
78: LDA 5,-4(5)	* push new frame
79: LDA 0,1(7)	* save return in ac
80: LDA 7,-74(7)	* relative jump to output function entry
81: LD 5,0(5)	 * pop current frame
* <- CallExp
82: ST 0,-4(5)	load user input
* -> CallExp
* -> SimpleVar
83: LD 0,-2(5)	load value of var into AC
84: ST 0,-5(5)	 <- constant
* <- SimpleVar
85: ST 5,-3(5)	* store current fp
86: LDA 5,-3(5)	* push new frame
87: LDA 0,1(7)	* save return in ac
88: LDA 7,-77(7)	* relative jump to function entry
89: LD 5,0(5)	 * pop current frame
* <- CallExp
90: ST 0,-3(5)	load user input
* -> SimpleVar
* looking up id: x
91: LDA 0,-3(5)	load id address
* <- id
92: ST 0,-5(5)	op: push left
* <- SimpleVar
93: LDC 0,101010101(0)	load const(101010101) <- constant
94: ST 0,-6(5)	load const(101010101) <- constant
95: LD 0,-5(5)	load address of lhs into ac
96: LD 1,-6(5)	load rhs constant into ac1
97: ST 1,0(0)	storing rhs constant into address of lhs
98: ST 1,-4(5)	storing rhs constant into offet of assignExp
* -> CallExp
* -> SimpleVar
99: LD 0,-3(5)	load value of var into AC
100: ST 0,-6(5)	 <- constant
* <- SimpleVar
101: ST 5,-4(5)	* store current fp
102: LDA 5,-4(5)	* push new frame
103: LDA 0,1(7)	* save return in ac
104: LDA 7,-98(7)	* relative jump to output function entry
105: LD 5,0(5)	 * pop current frame
* <- CallExp
106: ST 0,-4(5)	load user input
107: LD 7,-1(5)	return back to the caller
53: LDA 7,54(7)	jump forward to finale
108: ST 5,0(5)	push ofp
109: LDA 5,0(5)	push frame
110: LDA 0,1(7)	load ac with ret ptr
111: LDA 7,-58(7)	jump to main loc
112: LD 5,0(5)	pop frame
113: HALT 0,0,0	
