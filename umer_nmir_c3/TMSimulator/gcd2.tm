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
* processing function: gcd
12: ST 0,-1(5)	save return address
* -> if
* -> SimpleVar
13: LD 0,-3(5)	load value of var into AC
14: ST 0,-5(5)	 <- constant
* <- SimpleVar
15: LDC 0,0(0)	load const(0) <- constant
16: ST 0,-6(5)	load const(0) <- constant
17: LD 0,-5(5)	load lhs value into ac
18: LD 1,-6(5)	load rhs value into ac1
19: SUB 0,0,1	 sub values of ac and ac1 into ac
20: JEQ 0,2(7)	br if true
21: LDC 0,0(0)	false case
22: LDA 7,1(7)	unconditional jmp
23: LDC 0,1(0)	true case
* -> SimpleVar
25: LD 0,-2(5)	load value of var into AC
26: ST 0,-4(5)	 <- constant
* <- SimpleVar
27: LD 0,-4(5)	load return value into ac
28: LD 7,-1(5)	return back to the caller
24: JEQ 0,5(7)	jump to else
* -> CallExp
* -> SimpleVar
30: LD 0,-3(5)	load value of var into AC
31: ST 0,-4(5)	 <- constant
* <- SimpleVar
32: ST 0,-6(5)	Storing value of arg 1 into (-4)fp
* -> SimpleVar
33: LD 0,-2(5)	load value of var into AC
34: ST 0,-6(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
35: LD 0,-2(5)	load value of var into AC
36: ST 0,-9(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
37: LD 0,-3(5)	load value of var into AC
38: ST 0,-10(5)	 <- constant
* <- SimpleVar
39: LD 0,-9(5)	load lhs value into ac
40: LD 1,-10(5)	load rhs value into ac1
41: DIV 0,0,1	div values of ac and ac1 into ac
42: ST 0,-8(5)	storing rhs constant into address of lhs
* -> SimpleVar
43: LD 0,-3(5)	load value of var into AC
44: ST 0,-9(5)	 <- constant
* <- SimpleVar
45: LD 0,-8(5)	load lhs value into ac
46: LD 1,-9(5)	load rhs value into ac1
47: MUL 0,0,1	mul values of ac and ac1 into ac
48: ST 0,-7(5)	storing rhs constant into address of lhs
49: LD 0,-6(5)	load lhs value into ac
50: LD 1,-7(5)	load rhs value into ac1
51: SUB 0,0,1	sub values of ac and ac1 into ac
52: ST 0,-5(5)	storing rhs constant into address of lhs
53: ST 0,-7(5)	Storing value of arg 0 into (-5)fp
54: ST 5,-4(5)	* store current fp
55: LDA 5,-4(5)	* push new frame
56: LDA 0,1(7)	* save return in ac
57: LDA 7,-46(7)	* relative jump to function entry
58: LD 5,0(5)	 * pop current frame
* <- CallExp
59: ST 0,-4(5)	load user input
60: LD 0,-4(5)	load return value into ac
61: LD 7,-1(5)	return back to the caller
29: LDA 7,32(7)	unconditional jump to end
* <- if
62: LD 7,-1(5)	return back to the caller
11: LDA 7,51(7)	jump forward to finale
* processing function: main
64: ST 0,-1(5)	save return address
* -> SimpleVar
* looking up id: x
65: LDA 0,-2(5)	load id address
* <- id
66: ST 0,-4(5)	op: push left
* <- SimpleVar
* -> CallExp
67: ST 5,-5(5)	* store current fp
68: LDA 5,-5(5)	* push new frame
69: LDA 0,1(7)	* save return in ac
70: LDA 7,-67(7)	* relative jump to input function entry
71: LD 5,0(5)	 * pop current frame
* <- CallExp
72: ST 0,-5(5)	load user input
73: LD 0,-4(5)	load address of lhs into ac
74: LD 1,-5(5)	load rhs constant into ac1
75: ST 1,0(0)	storing rhs constant into address of lhs
76: ST 1,-2(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
* looking up id: y
77: LDA 0,0(6)	load id address
* <- id
78: ST 0,-4(5)	op: push left
* <- SimpleVar
79: LDC 0,10(0)	load const(10) <- constant
80: ST 0,-5(5)	load const(10) <- constant
81: LD 0,-4(5)	load address of lhs into ac
82: LD 1,-5(5)	load rhs constant into ac1
83: ST 1,0(0)	storing rhs constant into address of lhs
84: ST 1,0(6)	storing rhs constant into offet of assignExp
* -> CallExp
* -> CallExp
* -> SimpleVar
85: LD 0,-2(5)	load value of var into AC
86: ST 0,-3(5)	 <- constant
* <- SimpleVar
87: ST 0,-5(5)	Storing value of arg 1 into (-3)fp
* -> SimpleVar
88: LD 0,0(6)	load value of var into AC
89: ST 0,-4(5)	 <- constant
* <- SimpleVar
90: ST 0,-6(5)	Storing value of arg 0 into (-4)fp
91: ST 5,-3(5)	* store current fp
92: LDA 5,-3(5)	* push new frame
93: LDA 0,1(7)	* save return in ac
94: LDA 7,-83(7)	* relative jump to function entry
95: LD 5,0(5)	 * pop current frame
* <- CallExp
96: ST 0,-3(5)	load user input
97: ST 0,-5(5)	Storing value of arg 1 into (-3)fp
98: ST 5,-3(5)	* store current fp
99: LDA 5,-3(5)	* push new frame
100: LDA 0,1(7)	* save return in ac
101: LDA 7,-95(7)	* relative jump to output function entry
102: LD 5,0(5)	 * pop current frame
* <- CallExp
103: ST 0,-3(5)	load user input
104: LD 7,-1(5)	return back to the caller
63: LDA 7,41(7)	jump forward to finale
105: ST 5,-1(5)	push ofp
106: LDA 5,-1(5)	push frame
107: LDA 0,1(7)	load ac with ret ptr
108: LDA 7,-45(7)	jump to main loc
109: LD 5,0(5)	pop frame
110: HALT 0,0,0	
