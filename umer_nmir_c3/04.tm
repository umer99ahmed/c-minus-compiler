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
14: ST 0,-6(5)	 <- constant
* <- SimpleVar
15: LDC 0,0(0)	load const(0) <- constant
16: ST 0,-7(5)	load const(0) <- constant
17: LD 0,-6(5)	load lhs value into ac
18: LD 1,-7(5)	load rhs value into ac1
19: SUB 0,0,1	 sub values of ac and ac1 into ac
20: JEQ 0,2(7)	br if true
21: LDC 0,0(0)	false case
22: LDA 7,1(7)	unconditional jmp
23: LDC 0,1(0)	true case
* -> CallExp
25: LDC 0,111(0)	load const(111) <- constant
26: ST 0,-7(5)	load const(111) <- constant
27: ST 5,-5(5)	* store current fp
28: LDA 5,-5(5)	* push new frame
29: LDA 0,1(7)	* save return in ac
30: LDA 7,-24(7)	* relative jump to output function entry
31: LD 5,0(5)	 * pop current frame
* <- CallExp
32: ST 0,-5(5)	load user input
* -> CallExp
* -> SimpleVar
33: LD 0,-2(5)	load value of var into AC
34: ST 0,-7(5)	 <- constant
* <- SimpleVar
35: ST 5,-5(5)	* store current fp
36: LDA 5,-5(5)	* push new frame
37: LDA 0,1(7)	* save return in ac
38: LDA 7,-32(7)	* relative jump to output function entry
39: LD 5,0(5)	 * pop current frame
* <- CallExp
40: ST 0,-5(5)	load user input
* -> CallExp
* -> SimpleVar
41: LD 0,-3(5)	load value of var into AC
42: ST 0,-7(5)	 <- constant
* <- SimpleVar
43: ST 5,-5(5)	* store current fp
44: LDA 5,-5(5)	* push new frame
45: LDA 0,1(7)	* save return in ac
46: LDA 7,-40(7)	* relative jump to output function entry
47: LD 5,0(5)	 * pop current frame
* <- CallExp
48: ST 0,-5(5)	load user input
* -> CallExp
49: LDC 0,111(0)	load const(111) <- constant
50: ST 0,-7(5)	load const(111) <- constant
51: ST 5,-5(5)	* store current fp
52: LDA 5,-5(5)	* push new frame
53: LDA 0,1(7)	* save return in ac
54: LDA 7,-48(7)	* relative jump to output function entry
55: LD 5,0(5)	 * pop current frame
* <- CallExp
56: ST 0,-5(5)	load user input
* -> SimpleVar
57: LD 0,-2(5)	load value of var into AC
58: ST 0,-5(5)	 <- constant
* <- SimpleVar
59: LD 0,-5(5)	load return value into ac
60: LD 7,-1(5)	return back to the caller
24: JEQ 0,37(7)	jump to else
* -> CallExp
62: LDC 0,999(0)	load const(999) <- constant
63: ST 0,-7(5)	load const(999) <- constant
64: ST 5,-5(5)	* store current fp
65: LDA 5,-5(5)	* push new frame
66: LDA 0,1(7)	* save return in ac
67: LDA 7,-61(7)	* relative jump to output function entry
68: LD 5,0(5)	 * pop current frame
* <- CallExp
69: ST 0,-5(5)	load user input
* -> CallExp
* -> SimpleVar
70: LD 0,-2(5)	load value of var into AC
71: ST 0,-7(5)	 <- constant
* <- SimpleVar
72: ST 5,-5(5)	* store current fp
73: LDA 5,-5(5)	* push new frame
74: LDA 0,1(7)	* save return in ac
75: LDA 7,-69(7)	* relative jump to output function entry
76: LD 5,0(5)	 * pop current frame
* <- CallExp
77: ST 0,-5(5)	load user input
* -> CallExp
* -> SimpleVar
78: LD 0,-3(5)	load value of var into AC
79: ST 0,-7(5)	 <- constant
* <- SimpleVar
80: ST 5,-5(5)	* store current fp
81: LDA 5,-5(5)	* push new frame
82: LDA 0,1(7)	* save return in ac
83: LDA 7,-77(7)	* relative jump to output function entry
84: LD 5,0(5)	 * pop current frame
* <- CallExp
85: ST 0,-5(5)	load user input
* -> CallExp
* -> SimpleVar
86: LD 0,-2(5)	load value of var into AC
87: ST 0,-8(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
88: LD 0,-2(5)	load value of var into AC
89: ST 0,-11(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
90: LD 0,-3(5)	load value of var into AC
91: ST 0,-12(5)	 <- constant
* <- SimpleVar
92: LD 0,-11(5)	load lhs value into ac
93: LD 1,-12(5)	load rhs value into ac1
94: DIV 0,0,1	div values of ac and ac1 into ac
95: ST 0,-10(5)	storing rhs constant into address of lhs
* -> SimpleVar
96: LD 0,-3(5)	load value of var into AC
97: ST 0,-11(5)	 <- constant
* <- SimpleVar
98: LD 0,-10(5)	load lhs value into ac
99: LD 1,-11(5)	load rhs value into ac1
100: MUL 0,0,1	mul values of ac and ac1 into ac
101: ST 0,-9(5)	storing rhs constant into address of lhs
102: LD 0,-8(5)	load lhs value into ac
103: LD 1,-9(5)	load rhs value into ac1
104: SUB 0,0,1	sub values of ac and ac1 into ac
105: ST 0,-7(5)	storing rhs constant into address of lhs
106: ST 5,-5(5)	* store current fp
107: LDA 5,-5(5)	* push new frame
108: LDA 0,1(7)	* save return in ac
109: LDA 7,-103(7)	* relative jump to output function entry
110: LD 5,0(5)	 * pop current frame
* <- CallExp
111: ST 0,-5(5)	load user input
* -> CallExp
112: LDC 0,999(0)	load const(999) <- constant
113: ST 0,-7(5)	load const(999) <- constant
114: ST 5,-5(5)	* store current fp
115: LDA 5,-5(5)	* push new frame
116: LDA 0,1(7)	* save return in ac
117: LDA 7,-111(7)	* relative jump to output function entry
118: LD 5,0(5)	 * pop current frame
* <- CallExp
119: ST 0,-5(5)	load user input
* -> SimpleVar
* looking up id: temp
120: LDA 0,-4(5)	load id address
* <- id
121: ST 0,-6(5)	op: push left
* <- SimpleVar
* -> CallExp
* -> SimpleVar
122: LD 0,-3(5)	load value of var into AC
123: ST 0,-9(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
124: LD 0,-2(5)	load value of var into AC
125: ST 0,-11(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
126: LD 0,-2(5)	load value of var into AC
127: ST 0,-14(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
128: LD 0,-3(5)	load value of var into AC
129: ST 0,-15(5)	 <- constant
* <- SimpleVar
130: LD 0,-14(5)	load lhs value into ac
131: LD 1,-15(5)	load rhs value into ac1
132: DIV 0,0,1	div values of ac and ac1 into ac
133: ST 0,-13(5)	storing rhs constant into address of lhs
* -> SimpleVar
134: LD 0,-3(5)	load value of var into AC
135: ST 0,-14(5)	 <- constant
* <- SimpleVar
136: LD 0,-13(5)	load lhs value into ac
137: LD 1,-14(5)	load rhs value into ac1
138: MUL 0,0,1	mul values of ac and ac1 into ac
139: ST 0,-12(5)	storing rhs constant into address of lhs
140: LD 0,-11(5)	load lhs value into ac
141: LD 1,-12(5)	load rhs value into ac1
142: SUB 0,0,1	sub values of ac and ac1 into ac
143: ST 0,-10(5)	storing rhs constant into address of lhs
144: ST 5,-7(5)	* store current fp
145: LDA 5,-7(5)	* push new frame
146: LDA 0,1(7)	* save return in ac
147: LDA 7,-136(7)	* relative jump to function entry
148: LD 5,0(5)	 * pop current frame
* <- CallExp
149: ST 0,-7(5)	load user input
150: LD 0,-6(5)	load address of lhs into ac
151: LD 1,-7(5)	load rhs constant into ac1
152: ST 1,0(0)	storing rhs constant into address of lhs
153: ST 1,-4(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
154: LD 0,-4(5)	load value of var into AC
155: ST 0,-5(5)	 <- constant
* <- SimpleVar
156: LD 0,-5(5)	load return value into ac
157: LD 7,-1(5)	return back to the caller
61: LDA 7,96(7)	unconditional jump to end
* <- if
158: LD 7,-1(5)	return back to the caller
11: LDA 7,147(7)	jump forward to finale
* processing function: main
160: ST 0,-1(5)	save return address
* -> SimpleVar
* looking up id: x
161: LDA 0,-2(5)	load id address
* <- id
162: ST 0,-4(5)	op: push left
* <- SimpleVar
* -> CallExp
163: ST 5,-5(5)	* store current fp
164: LDA 5,-5(5)	* push new frame
165: LDA 0,1(7)	* save return in ac
166: LDA 7,-163(7)	* relative jump to input function entry
167: LD 5,0(5)	 * pop current frame
* <- CallExp
168: ST 0,-5(5)	load user input
169: LD 0,-4(5)	load address of lhs into ac
170: LD 1,-5(5)	load rhs constant into ac1
171: ST 1,0(0)	storing rhs constant into address of lhs
172: ST 1,-2(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
* looking up id: y
173: LDA 0,0(6)	load id address
* <- id
174: ST 0,-4(5)	op: push left
* <- SimpleVar
175: LDC 0,10(0)	load const(10) <- constant
176: ST 0,-5(5)	load const(10) <- constant
177: LD 0,-4(5)	load address of lhs into ac
178: LD 1,-5(5)	load rhs constant into ac1
179: ST 1,0(0)	storing rhs constant into address of lhs
180: ST 1,0(6)	storing rhs constant into offet of assignExp
* -> CallExp
* -> CallExp
* -> SimpleVar
181: LD 0,-2(5)	load value of var into AC
182: ST 0,-7(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
183: LD 0,0(6)	load value of var into AC
184: ST 0,-8(5)	 <- constant
* <- SimpleVar
185: ST 5,-5(5)	* store current fp
186: LDA 5,-5(5)	* push new frame
187: LDA 0,1(7)	* save return in ac
188: LDA 7,-177(7)	* relative jump to function entry
189: LD 5,0(5)	 * pop current frame
* <- CallExp
190: ST 0,-5(5)	load user input
191: ST 5,-3(5)	* store current fp
192: LDA 5,-3(5)	* push new frame
193: LDA 0,1(7)	* save return in ac
194: LDA 7,-188(7)	* relative jump to output function entry
195: LD 5,0(5)	 * pop current frame
* <- CallExp
196: ST 0,-3(5)	load user input
197: LD 7,-1(5)	return back to the caller
159: LDA 7,38(7)	jump forward to finale
198: ST 5,-1(5)	push ofp
199: LDA 5,-1(5)	push frame
200: LDA 0,1(7)	load ac with ret ptr
201: LDA 7,-42(7)	jump to main loc
202: LD 5,0(5)	pop frame
203: HALT 0,0,0	
