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
26: ST 0,-5(5)	load const(111) <- constant
27: ST 0,-7(5)	Storing value of arg 1 into (-5)fp
28: ST 5,-5(5)	* store current fp
29: LDA 5,-5(5)	* push new frame
30: LDA 0,1(7)	* save return in ac
31: LDA 7,-25(7)	* relative jump to output function entry
32: LD 5,0(5)	 * pop current frame
* <- CallExp
33: ST 0,-5(5)	load user input
* -> CallExp
* -> SimpleVar
34: LD 0,-2(5)	load value of var into AC
35: ST 0,-5(5)	 <- constant
* <- SimpleVar
36: ST 0,-7(5)	Storing value of arg 1 into (-5)fp
37: ST 5,-5(5)	* store current fp
38: LDA 5,-5(5)	* push new frame
39: LDA 0,1(7)	* save return in ac
40: LDA 7,-34(7)	* relative jump to output function entry
41: LD 5,0(5)	 * pop current frame
* <- CallExp
42: ST 0,-5(5)	load user input
* -> CallExp
* -> SimpleVar
43: LD 0,-3(5)	load value of var into AC
44: ST 0,-5(5)	 <- constant
* <- SimpleVar
45: ST 0,-7(5)	Storing value of arg 1 into (-5)fp
46: ST 5,-5(5)	* store current fp
47: LDA 5,-5(5)	* push new frame
48: LDA 0,1(7)	* save return in ac
49: LDA 7,-43(7)	* relative jump to output function entry
50: LD 5,0(5)	 * pop current frame
* <- CallExp
51: ST 0,-5(5)	load user input
* -> CallExp
52: LDC 0,111(0)	load const(111) <- constant
53: ST 0,-5(5)	load const(111) <- constant
54: ST 0,-7(5)	Storing value of arg 1 into (-5)fp
55: ST 5,-5(5)	* store current fp
56: LDA 5,-5(5)	* push new frame
57: LDA 0,1(7)	* save return in ac
58: LDA 7,-52(7)	* relative jump to output function entry
59: LD 5,0(5)	 * pop current frame
* <- CallExp
60: ST 0,-5(5)	load user input
* -> SimpleVar
61: LD 0,-2(5)	load value of var into AC
62: ST 0,-5(5)	 <- constant
* <- SimpleVar
63: LD 0,-5(5)	load return value into ac
64: LD 7,-1(5)	return back to the caller
24: JEQ 0,41(7)	jump to else
* -> CallExp
66: LDC 0,999(0)	load const(999) <- constant
67: ST 0,-5(5)	load const(999) <- constant
68: ST 0,-7(5)	Storing value of arg 1 into (-5)fp
69: ST 5,-5(5)	* store current fp
70: LDA 5,-5(5)	* push new frame
71: LDA 0,1(7)	* save return in ac
72: LDA 7,-66(7)	* relative jump to output function entry
73: LD 5,0(5)	 * pop current frame
* <- CallExp
74: ST 0,-5(5)	load user input
* -> CallExp
* -> SimpleVar
75: LD 0,-2(5)	load value of var into AC
76: ST 0,-5(5)	 <- constant
* <- SimpleVar
77: ST 0,-7(5)	Storing value of arg 1 into (-5)fp
78: ST 5,-5(5)	* store current fp
79: LDA 5,-5(5)	* push new frame
80: LDA 0,1(7)	* save return in ac
81: LDA 7,-75(7)	* relative jump to output function entry
82: LD 5,0(5)	 * pop current frame
* <- CallExp
83: ST 0,-5(5)	load user input
* -> CallExp
* -> SimpleVar
84: LD 0,-3(5)	load value of var into AC
85: ST 0,-5(5)	 <- constant
* <- SimpleVar
86: ST 0,-7(5)	Storing value of arg 1 into (-5)fp
87: ST 5,-5(5)	* store current fp
88: LDA 5,-5(5)	* push new frame
89: LDA 0,1(7)	* save return in ac
90: LDA 7,-84(7)	* relative jump to output function entry
91: LD 5,0(5)	 * pop current frame
* <- CallExp
92: ST 0,-5(5)	load user input
* -> CallExp
* -> SimpleVar
93: LD 0,-2(5)	load value of var into AC
94: ST 0,-6(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
95: LD 0,-2(5)	load value of var into AC
96: ST 0,-9(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
97: LD 0,-3(5)	load value of var into AC
98: ST 0,-10(5)	 <- constant
* <- SimpleVar
99: LD 0,-9(5)	load lhs value into ac
100: LD 1,-10(5)	load rhs value into ac1
101: DIV 0,0,1	div values of ac and ac1 into ac
102: ST 0,-8(5)	storing rhs constant into address of lhs
* -> SimpleVar
103: LD 0,-3(5)	load value of var into AC
104: ST 0,-9(5)	 <- constant
* <- SimpleVar
105: LD 0,-8(5)	load lhs value into ac
106: LD 1,-9(5)	load rhs value into ac1
107: MUL 0,0,1	mul values of ac and ac1 into ac
108: ST 0,-7(5)	storing rhs constant into address of lhs
109: LD 0,-6(5)	load lhs value into ac
110: LD 1,-7(5)	load rhs value into ac1
111: SUB 0,0,1	sub values of ac and ac1 into ac
112: ST 0,-5(5)	storing rhs constant into address of lhs
113: ST 0,-7(5)	Storing value of arg 1 into (-5)fp
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
123: ST 0,-7(5)	 <- constant
* <- SimpleVar
124: ST 0,-9(5)	Storing value of arg 1 into (-7)fp
* -> SimpleVar
125: LD 0,-2(5)	load value of var into AC
126: ST 0,-8(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
127: LD 0,-2(5)	load value of var into AC
128: ST 0,-11(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
129: LD 0,-3(5)	load value of var into AC
130: ST 0,-12(5)	 <- constant
* <- SimpleVar
131: LD 0,-11(5)	load lhs value into ac
132: LD 1,-12(5)	load rhs value into ac1
133: DIV 0,0,1	div values of ac and ac1 into ac
134: ST 0,-10(5)	storing rhs constant into address of lhs
* -> SimpleVar
135: LD 0,-3(5)	load value of var into AC
136: ST 0,-11(5)	 <- constant
* <- SimpleVar
137: LD 0,-10(5)	load lhs value into ac
138: LD 1,-11(5)	load rhs value into ac1
139: MUL 0,0,1	mul values of ac and ac1 into ac
140: ST 0,-9(5)	storing rhs constant into address of lhs
141: LD 0,-8(5)	load lhs value into ac
142: LD 1,-9(5)	load rhs value into ac1
143: SUB 0,0,1	sub values of ac and ac1 into ac
144: ST 0,-7(5)	storing rhs constant into address of lhs
145: ST 0,-10(5)	Storing value of arg 0 into (-8)fp
146: ST 5,-7(5)	* store current fp
147: LDA 5,-7(5)	* push new frame
148: LDA 0,1(7)	* save return in ac
149: LDA 7,-138(7)	* relative jump to function entry
150: LD 5,0(5)	 * pop current frame
* <- CallExp
151: ST 0,-7(5)	load user input
152: LD 0,-6(5)	load address of lhs into ac
153: LD 1,-7(5)	load rhs constant into ac1
154: ST 1,0(0)	storing rhs constant into address of lhs
155: ST 1,-4(5)	storing rhs constant into offet of assignExp
* -> CallExp
* -> SimpleVar
156: LD 0,-4(5)	load value of var into AC
157: ST 0,-5(5)	 <- constant
* <- SimpleVar
158: ST 0,-7(5)	Storing value of arg 1 into (-5)fp
159: ST 5,-5(5)	* store current fp
160: LDA 5,-5(5)	* push new frame
161: LDA 0,1(7)	* save return in ac
162: LDA 7,-156(7)	* relative jump to output function entry
163: LD 5,0(5)	 * pop current frame
* <- CallExp
164: ST 0,-5(5)	load user input
* -> CallExp
165: LDC 0,999(0)	load const(999) <- constant
166: ST 0,-5(5)	load const(999) <- constant
167: ST 0,-7(5)	Storing value of arg 1 into (-5)fp
168: ST 5,-5(5)	* store current fp
169: LDA 5,-5(5)	* push new frame
170: LDA 0,1(7)	* save return in ac
171: LDA 7,-165(7)	* relative jump to output function entry
172: LD 5,0(5)	 * pop current frame
* <- CallExp
173: ST 0,-5(5)	load user input
* -> SimpleVar
174: LD 0,-4(5)	load value of var into AC
175: ST 0,-5(5)	 <- constant
* <- SimpleVar
176: LD 0,-5(5)	load return value into ac
177: LD 7,-1(5)	return back to the caller
65: LDA 7,112(7)	unconditional jump to end
* <- if
178: LD 7,-1(5)	return back to the caller
11: LDA 7,167(7)	jump forward to finale
* processing function: main
180: ST 0,-1(5)	save return address
* -> SimpleVar
* looking up id: x
181: LDA 0,-2(5)	load id address
* <- id
182: ST 0,-4(5)	op: push left
* <- SimpleVar
* -> CallExp
183: ST 5,-5(5)	* store current fp
184: LDA 5,-5(5)	* push new frame
185: LDA 0,1(7)	* save return in ac
186: LDA 7,-183(7)	* relative jump to input function entry
187: LD 5,0(5)	 * pop current frame
* <- CallExp
188: ST 0,-5(5)	load user input
189: LD 0,-4(5)	load address of lhs into ac
190: LD 1,-5(5)	load rhs constant into ac1
191: ST 1,0(0)	storing rhs constant into address of lhs
192: ST 1,-2(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
* looking up id: y
193: LDA 0,0(6)	load id address
* <- id
194: ST 0,-4(5)	op: push left
* <- SimpleVar
195: LDC 0,10(0)	load const(10) <- constant
196: ST 0,-5(5)	load const(10) <- constant
197: LD 0,-4(5)	load address of lhs into ac
198: LD 1,-5(5)	load rhs constant into ac1
199: ST 1,0(0)	storing rhs constant into address of lhs
200: ST 1,0(6)	storing rhs constant into offet of assignExp
* -> CallExp
* -> CallExp
* -> SimpleVar
201: LD 0,-2(5)	load value of var into AC
202: ST 0,-3(5)	 <- constant
* <- SimpleVar
203: ST 0,-5(5)	Storing value of arg 1 into (-3)fp
* -> SimpleVar
204: LD 0,0(6)	load value of var into AC
205: ST 0,-3(5)	 <- constant
* <- SimpleVar
206: ST 0,-6(5)	Storing value of arg 0 into (-4)fp
207: ST 5,-3(5)	* store current fp
208: LDA 5,-3(5)	* push new frame
209: LDA 0,1(7)	* save return in ac
210: LDA 7,-199(7)	* relative jump to function entry
211: LD 5,0(5)	 * pop current frame
* <- CallExp
212: ST 0,-3(5)	load user input
213: ST 0,-5(5)	Storing value of arg 1 into (-3)fp
214: ST 5,-3(5)	* store current fp
215: LDA 5,-3(5)	* push new frame
216: LDA 0,1(7)	* save return in ac
217: LDA 7,-211(7)	* relative jump to output function entry
218: LD 5,0(5)	 * pop current frame
* <- CallExp
219: ST 0,-3(5)	load user input
220: LD 7,-1(5)	return back to the caller
179: LDA 7,41(7)	jump forward to finale
221: ST 5,-1(5)	push ofp
222: LDA 5,-1(5)	push frame
223: LDA 0,1(7)	load ac with ret ptr
224: LDA 7,-45(7)	jump to main loc
225: LD 5,0(5)	pop frame
226: HALT 0,0,0	
