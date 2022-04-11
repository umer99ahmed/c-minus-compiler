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
* -> SimpleVar
* looking up id: i
13: LDA 0,-2(5)	load id address
* <- id
14: ST 0,-5(5)	op: push left
* <- SimpleVar
15: LDC 0,0(0)	load const(0) <- constant
16: ST 0,-6(5)	load const(0) <- constant
17: LD 0,-5(5)	load address of lhs into ac
18: LD 1,-6(5)	load rhs constant into ac1
19: ST 1,0(0)	storing rhs constant into address of lhs
20: ST 1,-4(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
* looking up id: j
21: LDA 0,-3(5)	load id address
* <- id
22: ST 0,-5(5)	op: push left
* <- SimpleVar
23: LDC 0,0(0)	load const(0) <- constant
24: ST 0,-6(5)	load const(0) <- constant
25: LD 0,-5(5)	load address of lhs into ac
26: LD 1,-6(5)	load rhs constant into ac1
27: ST 1,0(0)	storing rhs constant into address of lhs
28: ST 1,-4(5)	storing rhs constant into offet of assignExp
* -> while
* -> SimpleVar
29: LD 0,-2(5)	load value of var into AC
30: ST 0,-5(5)	 <- constant
* <- SimpleVar
31: LDC 0,10(0)	load const(10) <- constant
32: ST 0,-6(5)	load const(10) <- constant
33: LD 0,-5(5)	load lhs value into ac
34: LD 1,-6(5)	load rhs value into ac1
35: SUB 0,0,1	 sub values of ac and ac1 into ac
36: JLT 0,2(7)	br if true
37: LDC 0,0(0)	false case
38: LDA 7,1(7)	unconditional jmp
39: LDC 0,1(0)	true case
* -> IndexVar
* -> SimpleVar
41: LD 0,-2(5)	load value of var into AC
42: ST 0,-6(5)	 <- constant
* <- SimpleVar
* looking up id: x
43: LDA 0,-9(6)	load id address
44: ST 0,-5(5)	store array addr
45: LD 0,-6(5)	load value of index into ac
46: JLT 0,1(7)	halt if subscript < 0
47: LDA 7,1(7)	absolute jump if not
48: HALT 0,0,0	
49: LD 1,-5(5)	load array base addr
50: ADD 0,1,0	add offset + index
51: ST 0,-5(5)	store arg val
* -> IndexVar
* -> SimpleVar
52: LD 0,-2(5)	load value of var into AC
53: ST 0,-7(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
54: LD 0,-2(5)	load value of var into AC
55: ST 0,-8(5)	 <- constant
* <- SimpleVar
56: LD 0,-7(5)	load lhs value into ac
57: LD 1,-8(5)	load rhs value into ac1
58: MUL 0,0,1	mul values of ac and ac1 into ac
59: ST 0,-6(5)	storing rhs constant into address of lhs
60: LD 0,-5(5)	load address of lhs into ac
61: LD 1,-6(5)	load rhs constant into ac1
62: ST 1,0(0)	storing rhs constant into address of lhs
63: ST 1,-4(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
* looking up id: i
64: LDA 0,-2(5)	load id address
* <- id
65: ST 0,-5(5)	op: push left
* <- SimpleVar
* -> SimpleVar
66: LD 0,-2(5)	load value of var into AC
67: ST 0,-7(5)	 <- constant
* <- SimpleVar
68: LDC 0,1(0)	load const(1) <- constant
69: ST 0,-8(5)	load const(1) <- constant
70: LD 0,-7(5)	load lhs value into ac
71: LD 1,-8(5)	load rhs value into ac1
72: ADD 0,0,1	add values of ac and ac1 into ac
73: ST 0,-6(5)	storing rhs constant into address of lhs
74: LD 0,-5(5)	load address of lhs into ac
75: LD 1,-6(5)	load rhs constant into ac1
76: ST 1,0(0)	storing rhs constant into address of lhs
77: ST 1,-4(5)	storing rhs constant into offet of assignExp
78: LDA 7,-50(7)	while: absolute jmp to test
40: JEQ 0,38(7)	while: jmp to end
* <- while
* -> while
* -> SimpleVar
79: LD 0,-3(5)	load value of var into AC
80: ST 0,-5(5)	 <- constant
* <- SimpleVar
81: LDC 0,404(0)	load const(404) <- constant
82: ST 0,-6(5)	load const(404) <- constant
83: LD 0,-5(5)	load lhs value into ac
84: LD 1,-6(5)	load rhs value into ac1
85: SUB 0,0,1	 sub values of ac and ac1 into ac
86: JNE 0,2(7)	br if true
87: LDC 0,0(0)	false case
88: LDA 7,1(7)	unconditional jmp
89: LDC 0,1(0)	true case
* -> SimpleVar
* looking up id: j
91: LDA 0,-3(5)	load id address
* <- id
92: ST 0,-5(5)	op: push left
* <- SimpleVar
* -> CallExp
93: ST 5,-6(5)	* store current fp
94: LDA 5,-6(5)	* push new frame
95: LDA 0,1(7)	* save return in ac
96: LDA 7,-93(7)	* relative jump to input function entry
97: LD 5,0(5)	 * pop current frame
* <- CallExp
98: ST 0,-6(5)	load user input
99: LD 0,-5(5)	load address of lhs into ac
100: LD 1,-6(5)	load rhs constant into ac1
101: ST 1,0(0)	storing rhs constant into address of lhs
102: ST 1,-4(5)	storing rhs constant into offet of assignExp
* -> CallExp
* -> IndexVar
* -> SimpleVar
103: LD 0,-3(5)	load value of var into AC
104: ST 0,-7(5)	 <- constant
* <- SimpleVar
105: LDA 0,-9(6)	load id address
106: ST 0,-6(5)	store array addr
107: LD 0,-7(5)	load value of index into ac
108: JLT 0,1(7)	halt if subscript < 0
109: LDA 7,1(7)	absolute jump if not
110: HALT 0,0,0	
111: LDC 1,9(0)	size into ac1
112: SUB 0,1,0	sub size - index
113: JLT 0,1(7)	halt if subscript < 0
114: LDA 7,1(7)	absolute jump if not
115: HALT 0,0,0	
116: LD 0,-7(5)	load value of index into ac
117: LD 1,-6(5)	load array base addr
118: ADD 0,1,0	add offset + index
119: LD 0,0(0)	load value at array index 
120: ST 0,-6(5)	store arg val
* -> IndexVar
121: ST 5,-4(5)	* store current fp
122: LDA 5,-4(5)	* push new frame
123: LDA 0,1(7)	* save return in ac
124: LDA 7,-118(7)	* relative jump to output function entry
125: LD 5,0(5)	 * pop current frame
* <- CallExp
126: ST 0,-4(5)	load user input
127: LDA 7,-49(7)	while: absolute jmp to test
90: JEQ 0,37(7)	while: jmp to end
* <- while
128: LD 7,-1(5)	return back to the caller
11: LDA 7,117(7)	jump forward to finale
129: ST 5,-10(5)	push ofp
130: LDA 5,-10(5)	push frame
131: LDA 0,1(7)	load ac with ret ptr
132: LDA 7,-121(7)	jump to main loc
133: LD 5,0(5)	pop frame
134: HALT 0,0,0	
