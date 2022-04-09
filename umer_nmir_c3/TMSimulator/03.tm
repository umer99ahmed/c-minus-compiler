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
* processing function: func
12: ST 0,-1(5)	save return address
* -> CallExp
13: LD 0,0(5)	load value of var into AC
14: ST 0,-2(5)	 <- constant
15: ST 0,-4(5)	Storing value of arg 1 into (-2)fp
16: ST 5,-2(5)	* store current fp
17: LDA 5,-2(5)	* push new frame
18: LDA 0,1(7)	* save return in ac
19: LDA 7,-13(7)	* relative jump to output function entry
20: LD 5,0(5)	 * pop current frame
* <- CallExp
21: LD 7,-1(5)	return back to the caller
11: LDA 7,10(7)	jump forward to finale
* processing function: main
23: ST 0,-1(5)	save return address
* looking up id: x
24: LDA 0,-2(5)	load id address
* <- id
25: ST 0,-5(5)	op: push left
* -> CallExp
26: ST 5,-6(5)	* store current fp
27: LDA 5,-6(5)	* push new frame
28: LDA 0,1(7)	* save return in ac
29: LDA 7,-26(7)	* relative jump to input function entry
30: LD 5,0(5)	 * pop current frame
* <- CallExp
31: ST 0,-6(5)	load user input
32: LD 0,-5(5)	load address of lhs into ac
33: LD 1,-6(5)	load rhs constant into ac1
34: ST 1,0(0)	storing rhs constant into address of lhs
35: ST 1,-2(5)	storing rhs constant into offet of assignExp
* looking up id: fac
36: LDA 0,-3(5)	load id address
* <- id
37: ST 0,-5(5)	op: push left
38: LDC 0,1(0)	load const(1) <- constant
39: ST 0,-6(5)	load const(1) <- constant
40: LD 0,-5(5)	load address of lhs into ac
41: LD 1,-6(5)	load rhs constant into ac1
42: ST 1,0(0)	storing rhs constant into address of lhs
43: ST 1,-3(5)	storing rhs constant into offet of assignExp
* -> while
44: LD 0,-2(5)	load value of var into AC
45: ST 0,-5(5)	 <- constant
46: LDC 0,1(0)	load const(1) <- constant
47: ST 0,-6(5)	load const(1) <- constant
48: LD 0,-5(5)	load lhs value into ac
49: LD 1,-6(5)	load rhs value into ac1
50: SUB 0,0,1	 sub values of ac and ac1 into ac
51: JGT 0,2(7)	br if true
52: LDC 0,0(0)	false case
53: LDA 7,1(7)	unconditional jmp
54: LDC 0,1(0)	true case
* looking up id: fac
56: LDA 0,-3(5)	load id address
* <- id
57: ST 0,-5(5)	op: push left
58: LD 0,-3(5)	load value of var into AC
59: ST 0,-7(5)	 <- constant
60: LD 0,-2(5)	load value of var into AC
61: ST 0,-8(5)	 <- constant
62: LD 0,-7(5)	load lhs value into ac
63: LD 1,-8(5)	load rhs value into ac1
64: MUL 0,0,1	mul values of ac and ac1 into ac
65: ST 0,-6(5)	storing rhs constant into address of lhs
66: LD 0,-5(5)	load address of lhs into ac
67: LD 1,-6(5)	load rhs constant into ac1
68: ST 1,0(0)	storing rhs constant into address of lhs
69: ST 1,-3(5)	storing rhs constant into offet of assignExp
* looking up id: x
70: LDA 0,-2(5)	load id address
* <- id
71: ST 0,-5(5)	op: push left
72: LD 0,-2(5)	load value of var into AC
73: ST 0,-7(5)	 <- constant
74: LDC 0,1(0)	load const(1) <- constant
75: ST 0,-8(5)	load const(1) <- constant
76: LD 0,-7(5)	load lhs value into ac
77: LD 1,-8(5)	load rhs value into ac1
78: SUB 0,0,1	sub values of ac and ac1 into ac
79: ST 0,-6(5)	storing rhs constant into address of lhs
80: LD 0,-5(5)	load address of lhs into ac
81: LD 1,-6(5)	load rhs constant into ac1
82: ST 1,0(0)	storing rhs constant into address of lhs
83: ST 1,-2(5)	storing rhs constant into offet of assignExp
84: LDA 7,-41(7)	while: absolute jmp to test
55: JEQ 0,29(7)	while: jmp to end
* <- while
* -> CallExp
85: LD 0,-3(5)	load value of var into AC
86: ST 0,-5(5)	 <- constant
87: LD 0,-3(5)	load value of var into AC
88: ST 0,-6(5)	 <- constant
89: LD 0,-5(5)	load lhs value into ac
90: LD 1,-6(5)	load rhs value into ac1
91: MUL 0,0,1	mul values of ac and ac1 into ac
92: ST 0,-4(5)	storing rhs constant into address of lhs
93: ST 0,-6(5)	Storing value of arg 1 into (-4)fp
94: ST 5,-4(5)	* store current fp
95: LDA 5,-4(5)	* push new frame
96: LDA 0,1(7)	* save return in ac
97: LDA 7,-91(7)	* relative jump to output function entry
98: LD 5,0(5)	 * pop current frame
* <- CallExp
* -> CallExp
99: LD 0,-3(5)	load value of var into AC
100: ST 0,-4(5)	 <- constant
101: ST 0,-6(5)	Storing value of arg 1 into (-4)fp
102: ST 5,-4(5)	* store current fp
103: LDA 5,-4(5)	* push new frame
104: LDA 0,1(7)	* save return in ac
105: LDA 7,-94(7)	* relative jump to function entry
106: LD 5,0(5)	 * pop current frame
* <- CallExp
107: LD 7,-1(5)	return back to the caller
22: LDA 7,85(7)	jump forward to finale
108: ST 5,0(5)	push ofp
109: LDA 5,0(5)	push frame
110: LDA 0,1(7)	load ac with ret ptr
111: LDA 7,-89(7)	jump to main loc
112: LD 5,0(5)	pop frame
113: HALT 0,0,0	
