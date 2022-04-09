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
25: LD 0,-3(5)	load value of var into AC
26: ST 0,-4(5)	 <- constant
* <- SimpleVar
27: LD 0,-4(5)	load return value into ac
28: LD 7,-1(5)	return back to the caller
24: JEQ 0,5(7)	jump to else
* -> CallExp
30: LDC 0,1000000(0)	load const(1000000) <- constant
31: ST 0,-4(5)	load const(1000000) <- constant
32: ST 0,-6(5)	Storing value of arg 1 into (-4)fp
33: ST 5,-4(5)	* store current fp
34: LDA 5,-4(5)	* push new frame
35: LDA 0,1(7)	* save return in ac
36: LDA 7,-30(7)	* relative jump to output function entry
37: LD 5,0(5)	 * pop current frame
* <- CallExp
38: ST 0,-4(5)	load user input
* -> CallExp
* -> SimpleVar
39: LD 0,-2(5)	load value of var into AC
40: ST 0,-4(5)	 <- constant
* <- SimpleVar
41: ST 0,-6(5)	Storing value of arg 1 into (-4)fp
42: ST 5,-4(5)	* store current fp
43: LDA 5,-4(5)	* push new frame
44: LDA 0,1(7)	* save return in ac
45: LDA 7,-39(7)	* relative jump to output function entry
46: LD 5,0(5)	 * pop current frame
* <- CallExp
47: ST 0,-4(5)	load user input
* -> CallExp
* -> SimpleVar
48: LD 0,-3(5)	load value of var into AC
49: ST 0,-4(5)	 <- constant
* <- SimpleVar
50: ST 0,-6(5)	Storing value of arg 1 into (-4)fp
51: ST 5,-4(5)	* store current fp
52: LDA 5,-4(5)	* push new frame
53: LDA 0,1(7)	* save return in ac
54: LDA 7,-48(7)	* relative jump to output function entry
55: LD 5,0(5)	 * pop current frame
* <- CallExp
56: ST 0,-4(5)	load user input
* -> CallExp
* -> SimpleVar
57: LD 0,-3(5)	load value of var into AC
58: ST 0,-4(5)	 <- constant
* <- SimpleVar
59: ST 0,-6(5)	Storing value of arg 1 into (-4)fp
* -> SimpleVar
60: LD 0,-2(5)	load value of var into AC
61: ST 0,-5(5)	 <- constant
* <- SimpleVar
62: LDC 0,1(0)	load const(1) <- constant
63: ST 0,-6(5)	load const(1) <- constant
64: LD 0,-5(5)	load lhs value into ac
65: LD 1,-6(5)	load rhs value into ac1
66: SUB 0,0,1	sub values of ac and ac1 into ac
67: ST 0,-4(5)	storing rhs constant into address of lhs
68: ST 0,-7(5)	Storing value of arg 0 into (-5)fp
69: ST 5,-4(5)	* store current fp
70: LDA 5,-4(5)	* push new frame
71: LDA 0,1(7)	* save return in ac
72: LDA 7,-61(7)	* relative jump to function entry
73: LD 5,0(5)	 * pop current frame
* <- CallExp
74: ST 0,-4(5)	load user input
75: LD 0,-4(5)	load return value into ac
76: LD 7,-1(5)	return back to the caller
29: LDA 7,47(7)	unconditional jump to end
* <- if
77: LD 7,-1(5)	return back to the caller
11: LDA 7,66(7)	jump forward to finale
* processing function: main
79: ST 0,-1(5)	save return address
* -> SimpleVar
* looking up id: x
80: LDA 0,-2(5)	load id address
* <- id
81: ST 0,-4(5)	op: push left
* <- SimpleVar
* -> CallExp
82: ST 5,-5(5)	* store current fp
83: LDA 5,-5(5)	* push new frame
84: LDA 0,1(7)	* save return in ac
85: LDA 7,-82(7)	* relative jump to input function entry
86: LD 5,0(5)	 * pop current frame
* <- CallExp
87: ST 0,-5(5)	load user input
88: LD 0,-4(5)	load address of lhs into ac
89: LD 1,-5(5)	load rhs constant into ac1
90: ST 1,0(0)	storing rhs constant into address of lhs
91: ST 1,-2(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
* looking up id: y
92: LDA 0,0(6)	load id address
* <- id
93: ST 0,-4(5)	op: push left
* <- SimpleVar
94: LDC 0,10(0)	load const(10) <- constant
95: ST 0,-5(5)	load const(10) <- constant
96: LD 0,-4(5)	load address of lhs into ac
97: LD 1,-5(5)	load rhs constant into ac1
98: ST 1,0(0)	storing rhs constant into address of lhs
99: ST 1,0(6)	storing rhs constant into offet of assignExp
* -> CallExp
* -> CallExp
* -> SimpleVar
100: LD 0,-2(5)	load value of var into AC
101: ST 0,-3(5)	 <- constant
* <- SimpleVar
102: ST 0,-5(5)	Storing value of arg 1 into (-3)fp
* -> SimpleVar
103: LD 0,0(6)	load value of var into AC
104: ST 0,-3(5)	 <- constant
* <- SimpleVar
105: ST 0,-6(5)	Storing value of arg 0 into (-4)fp
106: ST 5,-3(5)	* store current fp
107: LDA 5,-3(5)	* push new frame
108: LDA 0,1(7)	* save return in ac
109: LDA 7,-98(7)	* relative jump to function entry
110: LD 5,0(5)	 * pop current frame
* <- CallExp
111: ST 0,-3(5)	load user input
112: ST 0,-5(5)	Storing value of arg 1 into (-3)fp
113: ST 5,-3(5)	* store current fp
114: LDA 5,-3(5)	* push new frame
115: LDA 0,1(7)	* save return in ac
116: LDA 7,-110(7)	* relative jump to output function entry
117: LD 5,0(5)	 * pop current frame
* <- CallExp
118: ST 0,-3(5)	load user input
119: LD 7,-1(5)	return back to the caller
78: LDA 7,41(7)	jump forward to finale
120: ST 5,-1(5)	push ofp
121: LDA 5,-1(5)	push frame
122: LDA 0,1(7)	load ac with ret ptr
123: LDA 7,-45(7)	jump to main loc
124: LD 5,0(5)	pop frame
125: HALT 0,0,0	
