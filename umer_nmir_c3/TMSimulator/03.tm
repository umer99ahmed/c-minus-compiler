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
* -> SimpleVar
13: LD 0,-2(5)	load value of var into AC
14: ST 0,-5(5)	 <- constant
* <- SimpleVar
15: ST 0,-7(5)	Storing value of arg 1 into (-5)fp
16: ST 5,-5(5)	* store current fp
17: LDA 5,-5(5)	* push new frame
18: LDA 0,1(7)	* save return in ac
19: LDA 7,-13(7)	* relative jump to output function entry
20: LD 5,0(5)	 * pop current frame
* <- CallExp
21: ST 0,-5(5)	load user input
* -> CallExp
22: LDC 0,1000(0)	load const(1000) <- constant
23: ST 0,-5(5)	load const(1000) <- constant
24: ST 0,-7(5)	Storing value of arg 1 into (-5)fp
25: ST 5,-5(5)	* store current fp
26: LDA 5,-5(5)	* push new frame
27: LDA 0,1(7)	* save return in ac
28: LDA 7,-22(7)	* relative jump to output function entry
29: LD 5,0(5)	 * pop current frame
* <- CallExp
30: ST 0,-5(5)	load user input
* -> CallExp
31: LDC 0,1001(0)	load const(1001) <- constant
32: ST 0,-5(5)	load const(1001) <- constant
33: ST 0,-7(5)	Storing value of arg 1 into (-5)fp
34: ST 5,-5(5)	* store current fp
35: LDA 5,-5(5)	* push new frame
36: LDA 0,1(7)	* save return in ac
37: LDA 7,-31(7)	* relative jump to output function entry
38: LD 5,0(5)	 * pop current frame
* <- CallExp
39: ST 0,-5(5)	load user input
* -> CallExp
* -> SimpleVar
40: LD 0,-2(5)	load value of var into AC
41: ST 0,-6(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
42: LD 0,-3(5)	load value of var into AC
43: ST 0,-8(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
44: LD 0,-4(5)	load value of var into AC
45: ST 0,-9(5)	 <- constant
* <- SimpleVar
46: LD 0,-8(5)	load lhs value into ac
47: LD 1,-9(5)	load rhs value into ac1
48: MUL 0,0,1	mul values of ac and ac1 into ac
49: ST 0,-7(5)	storing rhs constant into address of lhs
50: LD 0,-6(5)	load lhs value into ac
51: LD 1,-7(5)	load rhs value into ac1
52: ADD 0,0,1	add values of ac and ac1 into ac
53: ST 0,-5(5)	storing rhs constant into address of lhs
54: ST 0,-7(5)	Storing value of arg 1 into (-5)fp
55: ST 5,-5(5)	* store current fp
56: LDA 5,-5(5)	* push new frame
57: LDA 0,1(7)	* save return in ac
58: LDA 7,-52(7)	* relative jump to output function entry
59: LD 5,0(5)	 * pop current frame
* <- CallExp
60: ST 0,-5(5)	load user input
61: LD 0,-5(5)	load return value into ac
62: LD 7,-1(5)	return back to the caller
63: LD 7,-1(5)	return back to the caller
11: LDA 7,52(7)	jump forward to finale
* processing function: main
65: ST 0,-1(5)	save return address
* -> SimpleVar
* looking up id: x
66: LDA 0,-2(5)	load id address
* <- id
67: ST 0,-5(5)	op: push left
* <- SimpleVar
* -> CallExp
68: ST 5,-6(5)	* store current fp
69: LDA 5,-6(5)	* push new frame
70: LDA 0,1(7)	* save return in ac
71: LDA 7,-68(7)	* relative jump to input function entry
72: LD 5,0(5)	 * pop current frame
* <- CallExp
73: ST 0,-6(5)	load user input
74: LD 0,-5(5)	load address of lhs into ac
75: LD 1,-6(5)	load rhs constant into ac1
76: ST 1,0(0)	storing rhs constant into address of lhs
77: ST 1,-2(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
* looking up id: fac
78: LDA 0,-3(5)	load id address
* <- id
79: ST 0,-5(5)	op: push left
* <- SimpleVar
80: LDC 0,1(0)	load const(1) <- constant
81: ST 0,-6(5)	load const(1) <- constant
82: LD 0,-5(5)	load address of lhs into ac
83: LD 1,-6(5)	load rhs constant into ac1
84: ST 1,0(0)	storing rhs constant into address of lhs
85: ST 1,-3(5)	storing rhs constant into offet of assignExp
* -> while
* -> SimpleVar
86: LD 0,-2(5)	load value of var into AC
87: ST 0,-5(5)	 <- constant
* <- SimpleVar
88: LDC 0,1(0)	load const(1) <- constant
89: ST 0,-6(5)	load const(1) <- constant
90: LD 0,-5(5)	load lhs value into ac
91: LD 1,-6(5)	load rhs value into ac1
92: SUB 0,0,1	 sub values of ac and ac1 into ac
93: JGT 0,2(7)	br if true
94: LDC 0,0(0)	false case
95: LDA 7,1(7)	unconditional jmp
96: LDC 0,1(0)	true case
* -> SimpleVar
* looking up id: fac
98: LDA 0,-3(5)	load id address
* <- id
99: ST 0,-5(5)	op: push left
* <- SimpleVar
* -> SimpleVar
100: LD 0,-3(5)	load value of var into AC
101: ST 0,-7(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
102: LD 0,-2(5)	load value of var into AC
103: ST 0,-8(5)	 <- constant
* <- SimpleVar
104: LD 0,-7(5)	load lhs value into ac
105: LD 1,-8(5)	load rhs value into ac1
106: MUL 0,0,1	mul values of ac and ac1 into ac
107: ST 0,-6(5)	storing rhs constant into address of lhs
108: LD 0,-5(5)	load address of lhs into ac
109: LD 1,-6(5)	load rhs constant into ac1
110: ST 1,0(0)	storing rhs constant into address of lhs
111: ST 1,-3(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
* looking up id: x
112: LDA 0,-2(5)	load id address
* <- id
113: ST 0,-5(5)	op: push left
* <- SimpleVar
* -> SimpleVar
114: LD 0,-2(5)	load value of var into AC
115: ST 0,-7(5)	 <- constant
* <- SimpleVar
116: LDC 0,1(0)	load const(1) <- constant
117: ST 0,-8(5)	load const(1) <- constant
118: LD 0,-7(5)	load lhs value into ac
119: LD 1,-8(5)	load rhs value into ac1
120: SUB 0,0,1	sub values of ac and ac1 into ac
121: ST 0,-6(5)	storing rhs constant into address of lhs
122: LD 0,-5(5)	load address of lhs into ac
123: LD 1,-6(5)	load rhs constant into ac1
124: ST 1,0(0)	storing rhs constant into address of lhs
125: ST 1,-2(5)	storing rhs constant into offet of assignExp
126: LDA 7,-41(7)	while: absolute jmp to test
97: JEQ 0,29(7)	while: jmp to end
* <- while
* -> CallExp
* -> SimpleVar
127: LD 0,-3(5)	load value of var into AC
128: ST 0,-4(5)	 <- constant
* <- SimpleVar
129: ST 0,-6(5)	Storing value of arg 1 into (-4)fp
130: LDC 0,1(0)	load const(1) <- constant
131: ST 0,-4(5)	load const(1) <- constant
132: ST 0,-7(5)	Storing value of arg 0 into (-5)fp
133: LDC 0,2(0)	load const(2) <- constant
134: ST 0,-4(5)	load const(2) <- constant
135: ST 0,-8(5)	Storing value of arg -1 into (-6)fp
136: ST 5,-4(5)	* store current fp
137: LDA 5,-4(5)	* push new frame
138: LDA 0,1(7)	* save return in ac
139: LDA 7,-128(7)	* relative jump to function entry
140: LD 5,0(5)	 * pop current frame
* <- CallExp
141: ST 0,-4(5)	load user input
* -> CallExp
* -> SimpleVar
142: LD 0,-2(5)	load value of var into AC
143: ST 0,-4(5)	 <- constant
* <- SimpleVar
144: ST 0,-6(5)	Storing value of arg 1 into (-4)fp
145: ST 5,-4(5)	* store current fp
146: LDA 5,-4(5)	* push new frame
147: LDA 0,1(7)	* save return in ac
148: LDA 7,-142(7)	* relative jump to output function entry
149: LD 5,0(5)	 * pop current frame
* <- CallExp
150: ST 0,-4(5)	load user input
151: LD 0,-4(5)	load return value into ac
152: LD 7,-1(5)	return back to the caller
* -> SimpleVar
* looking up id: x
153: LDA 0,-2(5)	load id address
* <- id
154: ST 0,-5(5)	op: push left
* <- SimpleVar
155: LDC 0,0(0)	load const(0) <- constant
156: ST 0,-6(5)	load const(0) <- constant
157: LD 0,-5(5)	load address of lhs into ac
158: LD 1,-6(5)	load rhs constant into ac1
159: ST 1,0(0)	storing rhs constant into address of lhs
160: ST 1,-2(5)	storing rhs constant into offet of assignExp
* -> CallExp
* -> SimpleVar
161: LD 0,-2(5)	load value of var into AC
162: ST 0,-4(5)	 <- constant
* <- SimpleVar
163: ST 0,-6(5)	Storing value of arg 1 into (-4)fp
164: ST 5,-4(5)	* store current fp
165: LDA 5,-4(5)	* push new frame
166: LDA 0,1(7)	* save return in ac
167: LDA 7,-161(7)	* relative jump to output function entry
168: LD 5,0(5)	 * pop current frame
* <- CallExp
169: ST 0,-4(5)	load user input
170: LD 7,-1(5)	return back to the caller
64: LDA 7,106(7)	jump forward to finale
171: ST 5,0(5)	push ofp
172: LDA 5,0(5)	push frame
173: LDA 0,1(7)	load ac with ret ptr
174: LDA 7,-110(7)	jump to main loc
175: LD 5,0(5)	pop frame
176: HALT 0,0,0	
