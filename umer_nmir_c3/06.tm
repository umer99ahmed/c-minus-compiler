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
* processing function: par
12: ST 0,-1(5)	save return address
* -> SimpleVar
* looking up id: i
13: LDA 0,-3(5)	load id address
* <- id
14: ST 0,-5(5)	op: push left
* <- SimpleVar
15: LDC 0,0(0)	load const(0) <- constant
16: ST 0,-6(5)	load const(0) <- constant
17: LD 0,-5(5)	load address of lhs into ac
18: LD 1,-6(5)	load rhs constant into ac1
19: ST 1,0(0)	storing rhs constant into address of lhs
20: ST 1,-4(5)	storing rhs constant into offet of assignExp
* -> while
* -> SimpleVar
21: LD 0,-3(5)	load value of var into AC
22: ST 0,-5(5)	 <- constant
* <- SimpleVar
23: LDC 0,10(0)	load const(10) <- constant
24: ST 0,-6(5)	load const(10) <- constant
25: LD 0,-5(5)	load lhs value into ac
26: LD 1,-6(5)	load rhs value into ac1
27: SUB 0,0,1	 sub values of ac and ac1 into ac
28: JLT 0,2(7)	br if true
29: LDC 0,0(0)	false case
30: LDA 7,1(7)	unconditional jmp
31: LDC 0,1(0)	true case
* -> CallExp
* -> IndexVar
* -> SimpleVar
33: LD 0,-3(5)	load value of var into AC
34: ST 0,-7(5)	 <- constant
* <- SimpleVar
35: LDA 0,-2(5)	load id address
36: ST 0,-6(5)	store array addr
37: LD 0,-7(5)	load value of index into ac
38: LD 1,-6(5)	load array base addr
39: ADD 0,1,0	add offset + index
40: LD 0,0(0)	load value at array index 
41: ST 0,-6(5)	store arg val
* -> IndexVar
42: ST 5,-4(5)	* store current fp
43: LDA 5,-4(5)	* push new frame
44: LDA 0,1(7)	* save return in ac
45: LDA 7,-39(7)	* relative jump to output function entry
46: LD 5,0(5)	 * pop current frame
* <- CallExp
47: ST 0,-4(5)	load user input
* -> SimpleVar
* looking up id: i
48: LDA 0,-3(5)	load id address
* <- id
49: ST 0,-5(5)	op: push left
* <- SimpleVar
* -> SimpleVar
50: LD 0,-3(5)	load value of var into AC
51: ST 0,-7(5)	 <- constant
* <- SimpleVar
52: LDC 0,1(0)	load const(1) <- constant
53: ST 0,-8(5)	load const(1) <- constant
54: LD 0,-7(5)	load lhs value into ac
55: LD 1,-8(5)	load rhs value into ac1
56: ADD 0,0,1	add values of ac and ac1 into ac
57: ST 0,-6(5)	storing rhs constant into address of lhs
58: LD 0,-5(5)	load address of lhs into ac
59: LD 1,-6(5)	load rhs constant into ac1
60: ST 1,0(0)	storing rhs constant into address of lhs
61: ST 1,-4(5)	storing rhs constant into offet of assignExp
62: LDA 7,-42(7)	while: absolute jmp to test
32: JEQ 0,30(7)	while: jmp to end
* <- while
63: LD 7,-1(5)	return back to the caller
11: LDA 7,52(7)	jump forward to finale
* processing function: main
65: ST 0,-1(5)	save return address
* -> SimpleVar
* looking up id: i
66: LDA 0,-2(5)	load id address
* <- id
67: ST 0,-4(5)	op: push left
* <- SimpleVar
68: LDC 0,0(0)	load const(0) <- constant
69: ST 0,-5(5)	load const(0) <- constant
70: LD 0,-4(5)	load address of lhs into ac
71: LD 1,-5(5)	load rhs constant into ac1
72: ST 1,0(0)	storing rhs constant into address of lhs
73: ST 1,-3(5)	storing rhs constant into offet of assignExp
* -> while
* -> SimpleVar
74: LD 0,-2(5)	load value of var into AC
75: ST 0,-4(5)	 <- constant
* <- SimpleVar
76: LDC 0,10(0)	load const(10) <- constant
77: ST 0,-5(5)	load const(10) <- constant
78: LD 0,-4(5)	load lhs value into ac
79: LD 1,-5(5)	load rhs value into ac1
80: SUB 0,0,1	 sub values of ac and ac1 into ac
81: JLT 0,2(7)	br if true
82: LDC 0,0(0)	false case
83: LDA 7,1(7)	unconditional jmp
84: LDC 0,1(0)	true case
* -> IndexVar
* -> SimpleVar
86: LD 0,-2(5)	load value of var into AC
87: ST 0,-5(5)	 <- constant
* <- SimpleVar
* looking up id: a
88: LDA 0,-9(6)	load id address
89: ST 0,-4(5)	store array addr
90: LD 0,-5(5)	load value of index into ac
91: LD 1,-4(5)	load array base addr
92: ADD 0,1,0	add offset + index
93: ST 0,-4(5)	store arg val
* -> IndexVar
* -> CallExp
94: ST 5,-5(5)	* store current fp
95: LDA 5,-5(5)	* push new frame
96: LDA 0,1(7)	* save return in ac
97: LDA 7,-94(7)	* relative jump to input function entry
98: LD 5,0(5)	 * pop current frame
* <- CallExp
99: ST 0,-5(5)	load user input
100: LD 0,-4(5)	load address of lhs into ac
101: LD 1,-5(5)	load rhs constant into ac1
102: ST 1,0(0)	storing rhs constant into address of lhs
103: ST 1,-3(5)	storing rhs constant into offet of assignExp
* -> CallExp
* -> IndexVar
* -> SimpleVar
104: LD 0,-2(5)	load value of var into AC
105: ST 0,-6(5)	 <- constant
* <- SimpleVar
106: LDA 0,-9(6)	load id address
107: ST 0,-5(5)	store array addr
108: LD 0,-6(5)	load value of index into ac
109: LD 1,-5(5)	load array base addr
110: ADD 0,1,0	add offset + index
111: LD 0,0(0)	load value at array index 
112: ST 0,-5(5)	store arg val
* -> IndexVar
113: ST 5,-3(5)	* store current fp
114: LDA 5,-3(5)	* push new frame
115: LDA 0,1(7)	* save return in ac
116: LDA 7,-110(7)	* relative jump to output function entry
117: LD 5,0(5)	 * pop current frame
* <- CallExp
118: ST 0,-3(5)	load user input
* -> SimpleVar
* looking up id: i
119: LDA 0,-2(5)	load id address
* <- id
120: ST 0,-4(5)	op: push left
* <- SimpleVar
* -> SimpleVar
121: LD 0,-2(5)	load value of var into AC
122: ST 0,-6(5)	 <- constant
* <- SimpleVar
123: LDC 0,1(0)	load const(1) <- constant
124: ST 0,-7(5)	load const(1) <- constant
125: LD 0,-6(5)	load lhs value into ac
126: LD 1,-7(5)	load rhs value into ac1
127: ADD 0,0,1	add values of ac and ac1 into ac
128: ST 0,-5(5)	storing rhs constant into address of lhs
129: LD 0,-4(5)	load address of lhs into ac
130: LD 1,-5(5)	load rhs constant into ac1
131: ST 1,0(0)	storing rhs constant into address of lhs
132: ST 1,-3(5)	storing rhs constant into offet of assignExp
133: LDA 7,-60(7)	while: absolute jmp to test
85: JEQ 0,48(7)	while: jmp to end
* <- while
* -> SimpleVar
* looking up id: i
134: LDA 0,-2(5)	load id address
* <- id
135: ST 0,-4(5)	op: push left
* <- SimpleVar
136: LDC 0,0(0)	load const(0) <- constant
137: ST 0,-5(5)	load const(0) <- constant
138: LD 0,-4(5)	load address of lhs into ac
139: LD 1,-5(5)	load rhs constant into ac1
140: ST 1,0(0)	storing rhs constant into address of lhs
141: ST 1,-3(5)	storing rhs constant into offet of assignExp
* -> while
* -> SimpleVar
142: LD 0,-2(5)	load value of var into AC
143: ST 0,-4(5)	 <- constant
* <- SimpleVar
144: LDC 0,10(0)	load const(10) <- constant
145: ST 0,-5(5)	load const(10) <- constant
146: LD 0,-4(5)	load lhs value into ac
147: LD 1,-5(5)	load rhs value into ac1
148: SUB 0,0,1	 sub values of ac and ac1 into ac
149: JLT 0,2(7)	br if true
150: LDC 0,0(0)	false case
151: LDA 7,1(7)	unconditional jmp
152: LDC 0,1(0)	true case
* -> CallExp
* -> IndexVar
* -> SimpleVar
154: LD 0,-2(5)	load value of var into AC
155: ST 0,-6(5)	 <- constant
* <- SimpleVar
156: LDA 0,-9(6)	load id address
157: ST 0,-5(5)	store array addr
158: LD 0,-6(5)	load value of index into ac
159: LD 1,-5(5)	load array base addr
160: ADD 0,1,0	add offset + index
161: LD 0,0(0)	load value at array index 
162: ST 0,-5(5)	store arg val
* -> IndexVar
163: ST 5,-3(5)	* store current fp
164: LDA 5,-3(5)	* push new frame
165: LDA 0,1(7)	* save return in ac
166: LDA 7,-160(7)	* relative jump to output function entry
167: LD 5,0(5)	 * pop current frame
* <- CallExp
168: ST 0,-3(5)	load user input
* -> SimpleVar
* looking up id: i
169: LDA 0,-2(5)	load id address
* <- id
170: ST 0,-4(5)	op: push left
* <- SimpleVar
* -> SimpleVar
171: LD 0,-2(5)	load value of var into AC
172: ST 0,-6(5)	 <- constant
* <- SimpleVar
173: LDC 0,1(0)	load const(1) <- constant
174: ST 0,-7(5)	load const(1) <- constant
175: LD 0,-6(5)	load lhs value into ac
176: LD 1,-7(5)	load rhs value into ac1
177: ADD 0,0,1	add values of ac and ac1 into ac
178: ST 0,-5(5)	storing rhs constant into address of lhs
179: LD 0,-4(5)	load address of lhs into ac
180: LD 1,-5(5)	load rhs constant into ac1
181: ST 1,0(0)	storing rhs constant into address of lhs
182: ST 1,-3(5)	storing rhs constant into offet of assignExp
183: LDA 7,-42(7)	while: absolute jmp to test
153: JEQ 0,30(7)	while: jmp to end
* <- while
* -> CallExp
* -> SimpleVar
184: LD 0,-9(6)	load value of var into AC
185: ST 0,-5(5)	 <- constant
* <- SimpleVar
186: ST 5,-3(5)	* store current fp
187: LDA 5,-3(5)	* push new frame
188: LDA 0,1(7)	* save return in ac
189: LDA 7,-178(7)	* relative jump to function entry
190: LD 5,0(5)	 * pop current frame
* <- CallExp
191: ST 0,-3(5)	load user input
192: LD 7,-1(5)	return back to the caller
64: LDA 7,128(7)	jump forward to finale
193: ST 5,-10(5)	push ofp
194: LDA 5,-10(5)	push frame
195: LDA 0,1(7)	load ac with ret ptr
196: LDA 7,-132(7)	jump to main loc
197: LD 5,0(5)	pop frame
198: HALT 0,0,0	
