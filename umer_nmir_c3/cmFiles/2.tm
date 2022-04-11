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
31: ST 0,-6(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
32: LD 0,-2(5)	load value of var into AC
33: ST 0,-8(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
34: LD 0,-2(5)	load value of var into AC
35: ST 0,-11(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
36: LD 0,-3(5)	load value of var into AC
37: ST 0,-12(5)	 <- constant
* <- SimpleVar
38: LD 0,-11(5)	load lhs value into ac
39: LD 1,-12(5)	load rhs value into ac1
40: DIV 0,0,1	div values of ac and ac1 into ac
41: ST 0,-10(5)	storing rhs constant into address of lhs
* -> SimpleVar
42: LD 0,-3(5)	load value of var into AC
43: ST 0,-11(5)	 <- constant
* <- SimpleVar
44: LD 0,-10(5)	load lhs value into ac
45: LD 1,-11(5)	load rhs value into ac1
46: MUL 0,0,1	mul values of ac and ac1 into ac
47: ST 0,-9(5)	storing rhs constant into address of lhs
48: LD 0,-8(5)	load lhs value into ac
49: LD 1,-9(5)	load rhs value into ac1
50: SUB 0,0,1	sub values of ac and ac1 into ac
51: ST 0,-7(5)	storing rhs constant into address of lhs
52: ST 5,-4(5)	* store current fp
53: LDA 5,-4(5)	* push new frame
54: LDA 0,1(7)	* save return in ac
55: LDA 7,-44(7)	* relative jump to function entry
56: LD 5,0(5)	 * pop current frame
* <- CallExp
57: ST 0,-4(5)	load user input
58: LD 0,-4(5)	load return value into ac
59: LD 7,-1(5)	return back to the caller
29: LDA 7,30(7)	unconditional jump to end
* <- if
60: LD 7,-1(5)	return back to the caller
11: LDA 7,49(7)	jump forward to finale
* processing function: main
62: ST 0,-1(5)	save return address
* -> SimpleVar
* looking up id: x
63: LDA 0,-2(5)	load id address
* <- id
64: ST 0,-4(5)	op: push left
* <- SimpleVar
* -> CallExp
65: ST 5,-5(5)	* store current fp
66: LDA 5,-5(5)	* push new frame
67: LDA 0,1(7)	* save return in ac
68: LDA 7,-65(7)	* relative jump to input function entry
69: LD 5,0(5)	 * pop current frame
* <- CallExp
70: ST 0,-5(5)	load user input
71: LD 0,-4(5)	load address of lhs into ac
72: LD 1,-5(5)	load rhs constant into ac1
73: ST 1,0(0)	storing rhs constant into address of lhs
74: ST 1,-3(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
* looking up id: y
75: LDA 0,0(6)	load id address
* <- id
76: ST 0,-4(5)	op: push left
* <- SimpleVar
* -> CallExp
77: ST 5,-5(5)	* store current fp
78: LDA 5,-5(5)	* push new frame
79: LDA 0,1(7)	* save return in ac
80: LDA 7,-77(7)	* relative jump to input function entry
81: LD 5,0(5)	 * pop current frame
* <- CallExp
82: ST 0,-5(5)	load user input
83: LD 0,-4(5)	load address of lhs into ac
84: LD 1,-5(5)	load rhs constant into ac1
85: ST 1,0(0)	storing rhs constant into address of lhs
86: ST 1,-3(5)	storing rhs constant into offet of assignExp
* -> CallExp
* -> CallExp
* -> SimpleVar
87: LD 0,-2(5)	load value of var into AC
88: ST 0,-7(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
89: LD 0,0(6)	load value of var into AC
90: ST 0,-8(5)	 <- constant
* <- SimpleVar
91: ST 5,-5(5)	* store current fp
92: LDA 5,-5(5)	* push new frame
93: LDA 0,1(7)	* save return in ac
94: LDA 7,-83(7)	* relative jump to function entry
95: LD 5,0(5)	 * pop current frame
* <- CallExp
96: ST 0,-5(5)	load user input
97: ST 5,-3(5)	* store current fp
98: LDA 5,-3(5)	* push new frame
99: LDA 0,1(7)	* save return in ac
100: LDA 7,-94(7)	* relative jump to output function entry
101: LD 5,0(5)	 * pop current frame
* <- CallExp
102: ST 0,-3(5)	load user input
103: LD 7,-1(5)	return back to the caller
61: LDA 7,42(7)	jump forward to finale
104: ST 5,-1(5)	push ofp
105: LDA 5,-1(5)	push frame
106: LDA 0,1(7)	load ac with ret ptr
107: LDA 7,-46(7)	jump to main loc
108: LD 5,0(5)	pop frame
109: HALT 0,0,0	
