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
* processing function: minloc
12: ST 0,-1(5)	save return address
* -> SimpleVar
* looking up id: k
13: LDA 0,-6(5)	load id address
* <- id
14: ST 0,-8(5)	op: push left
* <- SimpleVar
* -> SimpleVar
15: LD 0,-2(5)	load value of var into AC
16: ST 0,-9(5)	 <- constant
* <- SimpleVar
17: LD 0,-8(5)	load address of lhs into ac
18: LD 1,-9(5)	load rhs constant into ac1
19: ST 1,0(0)	storing rhs constant into address of lhs
20: ST 1,-7(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
* looking up id: a
21: LDA 0,-5(5)	load id address
* <- id
22: ST 0,-8(5)	op: push left
* <- SimpleVar
* -> IndexVar
* -> SimpleVar
23: LD 0,-2(5)	load value of var into AC
24: ST 0,-10(5)	 <- constant
* <- SimpleVar
25: LDA 0,-9(6)	load id address
26: ST 0,-9(5)	store array addr
27: LD 0,-10(5)	load value of index into ac
28: LD 1,-9(5)	load array base addr
29: ADD 0,1,0	add offset + index
30: LD 0,0(0)	load value at array index 
31: ST 0,-9(5)	store arg val
* -> IndexVar
32: LD 0,-8(5)	load address of lhs into ac
33: LD 1,-9(5)	load rhs constant into ac1
34: ST 1,0(0)	storing rhs constant into address of lhs
35: ST 1,-7(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
* looking up id: i
36: LDA 0,-4(5)	load id address
* <- id
37: ST 0,-8(5)	op: push left
* <- SimpleVar
* -> SimpleVar
38: LD 0,-2(5)	load value of var into AC
39: ST 0,-10(5)	 <- constant
* <- SimpleVar
40: LDC 0,1(0)	load const(1) <- constant
41: ST 0,-11(5)	load const(1) <- constant
42: LD 0,-10(5)	load lhs value into ac
43: LD 1,-11(5)	load rhs value into ac1
44: ADD 0,0,1	add values of ac and ac1 into ac
45: ST 0,-9(5)	storing rhs constant into address of lhs
46: LD 0,-8(5)	load address of lhs into ac
47: LD 1,-9(5)	load rhs constant into ac1
48: ST 1,0(0)	storing rhs constant into address of lhs
49: ST 1,-7(5)	storing rhs constant into offet of assignExp
* -> while
* -> SimpleVar
50: LD 0,-4(5)	load value of var into AC
51: ST 0,-8(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
52: LD 0,-3(5)	load value of var into AC
53: ST 0,-9(5)	 <- constant
* <- SimpleVar
54: LD 0,-8(5)	load lhs value into ac
55: LD 1,-9(5)	load rhs value into ac1
56: SUB 0,0,1	 sub values of ac and ac1 into ac
57: JLT 0,2(7)	br if true
58: LDC 0,0(0)	false case
59: LDA 7,1(7)	unconditional jmp
60: LDC 0,1(0)	true case
* -> if
* -> IndexVar
* -> SimpleVar
62: LD 0,-4(5)	load value of var into AC
63: ST 0,-9(5)	 <- constant
* <- SimpleVar
64: LDA 0,-9(6)	load id address
65: ST 0,-8(5)	store array addr
66: LD 0,-9(5)	load value of index into ac
67: LD 1,-8(5)	load array base addr
68: ADD 0,1,0	add offset + index
69: LD 0,0(0)	load value at array index 
70: ST 0,-8(5)	store arg val
* -> IndexVar
* -> SimpleVar
71: LD 0,-5(5)	load value of var into AC
72: ST 0,-9(5)	 <- constant
* <- SimpleVar
73: LD 0,-8(5)	load lhs value into ac
74: LD 1,-9(5)	load rhs value into ac1
75: SUB 0,0,1	 sub values of ac and ac1 into ac
76: JLT 0,2(7)	br if true
77: LDC 0,0(0)	false case
78: LDA 7,1(7)	unconditional jmp
79: LDC 0,1(0)	true case
* -> SimpleVar
* looking up id: a
81: LDA 0,-5(5)	load id address
* <- id
82: ST 0,-8(5)	op: push left
* <- SimpleVar
* -> IndexVar
* -> SimpleVar
83: LD 0,-4(5)	load value of var into AC
84: ST 0,-10(5)	 <- constant
* <- SimpleVar
85: LDA 0,-9(6)	load id address
86: ST 0,-9(5)	store array addr
87: LD 0,-10(5)	load value of index into ac
88: LD 1,-9(5)	load array base addr
89: ADD 0,1,0	add offset + index
90: LD 0,0(0)	load value at array index 
91: ST 0,-9(5)	store arg val
* -> IndexVar
92: LD 0,-8(5)	load address of lhs into ac
93: LD 1,-9(5)	load rhs constant into ac1
94: ST 1,0(0)	storing rhs constant into address of lhs
95: ST 1,-7(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
* looking up id: k
96: LDA 0,-6(5)	load id address
* <- id
97: ST 0,-8(5)	op: push left
* <- SimpleVar
* -> SimpleVar
98: LD 0,-4(5)	load value of var into AC
99: ST 0,-9(5)	 <- constant
* <- SimpleVar
100: LD 0,-8(5)	load address of lhs into ac
101: LD 1,-9(5)	load rhs constant into ac1
102: ST 1,0(0)	storing rhs constant into address of lhs
103: ST 1,-7(5)	storing rhs constant into offet of assignExp
80: JEQ 0,24(7)	jump to else
104: LDA 7,0(7)	unconditional jump to end
* <- if
* -> SimpleVar
* looking up id: i
105: LDA 0,-4(5)	load id address
* <- id
106: ST 0,-8(5)	op: push left
* <- SimpleVar
* -> SimpleVar
107: LD 0,-4(5)	load value of var into AC
108: ST 0,-10(5)	 <- constant
* <- SimpleVar
109: LDC 0,1(0)	load const(1) <- constant
110: ST 0,-11(5)	load const(1) <- constant
111: LD 0,-10(5)	load lhs value into ac
112: LD 1,-11(5)	load rhs value into ac1
113: ADD 0,0,1	add values of ac and ac1 into ac
114: ST 0,-9(5)	storing rhs constant into address of lhs
115: LD 0,-8(5)	load address of lhs into ac
116: LD 1,-9(5)	load rhs constant into ac1
117: ST 1,0(0)	storing rhs constant into address of lhs
118: ST 1,-7(5)	storing rhs constant into offet of assignExp
119: LDA 7,-70(7)	while: absolute jmp to test
61: JEQ 0,58(7)	while: jmp to end
* <- while
* -> SimpleVar
120: LD 0,-6(5)	load value of var into AC
121: ST 0,-7(5)	 <- constant
* <- SimpleVar
122: LD 0,-7(5)	load return value into ac
123: LD 7,-1(5)	return back to the caller
124: LD 7,-1(5)	return back to the caller
11: LDA 7,113(7)	jump forward to finale
* processing function: sort
126: ST 0,-1(5)	save return address
* -> SimpleVar
* looking up id: i
127: LDA 0,-4(5)	load id address
* <- id
128: ST 0,-7(5)	op: push left
* <- SimpleVar
* -> SimpleVar
129: LD 0,-2(5)	load value of var into AC
130: ST 0,-8(5)	 <- constant
* <- SimpleVar
131: LD 0,-7(5)	load address of lhs into ac
132: LD 1,-8(5)	load rhs constant into ac1
133: ST 1,0(0)	storing rhs constant into address of lhs
134: ST 1,-6(5)	storing rhs constant into offet of assignExp
* -> while
* -> SimpleVar
135: LD 0,-4(5)	load value of var into AC
136: ST 0,-7(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
137: LD 0,-3(5)	load value of var into AC
138: ST 0,-9(5)	 <- constant
* <- SimpleVar
139: LDC 0,1(0)	load const(1) <- constant
140: ST 0,-10(5)	load const(1) <- constant
141: LD 0,-9(5)	load lhs value into ac
142: LD 1,-10(5)	load rhs value into ac1
143: SUB 0,0,1	sub values of ac and ac1 into ac
144: ST 0,-8(5)	storing rhs constant into address of lhs
145: LD 0,-7(5)	load lhs value into ac
146: LD 1,-8(5)	load rhs value into ac1
147: SUB 0,0,1	 sub values of ac and ac1 into ac
148: JLT 0,2(7)	br if true
149: LDC 0,0(0)	false case
150: LDA 7,1(7)	unconditional jmp
151: LDC 0,1(0)	true case
* -> SimpleVar
* looking up id: k
153: LDA 0,-5(5)	load id address
* <- id
154: ST 0,-8(5)	op: push left
* <- SimpleVar
* -> CallExp
* -> SimpleVar
155: LD 0,-4(5)	load value of var into AC
156: ST 0,-11(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
157: LD 0,-3(5)	load value of var into AC
158: ST 0,-12(5)	 <- constant
* <- SimpleVar
159: ST 5,-9(5)	* store current fp
160: LDA 5,-9(5)	* push new frame
161: LDA 0,1(7)	* save return in ac
162: LDA 7,-151(7)	* relative jump to function entry
163: LD 5,0(5)	 * pop current frame
* <- CallExp
164: ST 0,-9(5)	load user input
165: LD 0,-8(5)	load address of lhs into ac
166: LD 1,-9(5)	load rhs constant into ac1
167: ST 1,0(0)	storing rhs constant into address of lhs
168: ST 1,-7(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
* looking up id: t
169: LDA 0,-6(5)	load id address
* <- id
170: ST 0,-8(5)	op: push left
* <- SimpleVar
* -> IndexVar
* -> SimpleVar
171: LD 0,-5(5)	load value of var into AC
172: ST 0,-10(5)	 <- constant
* <- SimpleVar
173: LDA 0,-9(6)	load id address
174: ST 0,-9(5)	store array addr
175: LD 0,-10(5)	load value of index into ac
176: LD 1,-9(5)	load array base addr
177: ADD 0,1,0	add offset + index
178: LD 0,0(0)	load value at array index 
179: ST 0,-9(5)	store arg val
* -> IndexVar
180: LD 0,-8(5)	load address of lhs into ac
181: LD 1,-9(5)	load rhs constant into ac1
182: ST 1,0(0)	storing rhs constant into address of lhs
183: ST 1,-7(5)	storing rhs constant into offet of assignExp
* -> IndexVar
* -> SimpleVar
184: LD 0,-5(5)	load value of var into AC
185: ST 0,-9(5)	 <- constant
* <- SimpleVar
* looking up id: x
186: LDA 0,-9(6)	load id address
187: ST 0,-8(5)	store array addr
188: LD 0,-9(5)	load value of index into ac
189: LD 1,-8(5)	load array base addr
190: ADD 0,1,0	add offset + index
191: ST 0,-8(5)	store arg val
* -> IndexVar
* -> IndexVar
* -> SimpleVar
192: LD 0,-4(5)	load value of var into AC
193: ST 0,-10(5)	 <- constant
* <- SimpleVar
194: LDA 0,-9(6)	load id address
195: ST 0,-9(5)	store array addr
196: LD 0,-10(5)	load value of index into ac
197: LD 1,-9(5)	load array base addr
198: ADD 0,1,0	add offset + index
199: LD 0,0(0)	load value at array index 
200: ST 0,-9(5)	store arg val
* -> IndexVar
201: LD 0,-8(5)	load address of lhs into ac
202: LD 1,-9(5)	load rhs constant into ac1
203: ST 1,0(0)	storing rhs constant into address of lhs
204: ST 1,-7(5)	storing rhs constant into offet of assignExp
* -> IndexVar
* -> SimpleVar
205: LD 0,-4(5)	load value of var into AC
206: ST 0,-9(5)	 <- constant
* <- SimpleVar
* looking up id: x
207: LDA 0,-9(6)	load id address
208: ST 0,-8(5)	store array addr
209: LD 0,-9(5)	load value of index into ac
210: LD 1,-8(5)	load array base addr
211: ADD 0,1,0	add offset + index
212: ST 0,-8(5)	store arg val
* -> IndexVar
* -> SimpleVar
213: LD 0,-6(5)	load value of var into AC
214: ST 0,-9(5)	 <- constant
* <- SimpleVar
215: LD 0,-8(5)	load address of lhs into ac
216: LD 1,-9(5)	load rhs constant into ac1
217: ST 1,0(0)	storing rhs constant into address of lhs
218: ST 1,-7(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
* looking up id: i
219: LDA 0,-4(5)	load id address
* <- id
220: ST 0,-8(5)	op: push left
* <- SimpleVar
* -> SimpleVar
221: LD 0,-4(5)	load value of var into AC
222: ST 0,-10(5)	 <- constant
* <- SimpleVar
223: LDC 0,1(0)	load const(1) <- constant
224: ST 0,-11(5)	load const(1) <- constant
225: LD 0,-10(5)	load lhs value into ac
226: LD 1,-11(5)	load rhs value into ac1
227: ADD 0,0,1	add values of ac and ac1 into ac
228: ST 0,-9(5)	storing rhs constant into address of lhs
229: LD 0,-8(5)	load address of lhs into ac
230: LD 1,-9(5)	load rhs constant into ac1
231: ST 1,0(0)	storing rhs constant into address of lhs
232: ST 1,-7(5)	storing rhs constant into offet of assignExp
233: LDA 7,-99(7)	while: absolute jmp to test
152: JEQ 0,81(7)	while: jmp to end
* <- while
234: LD 7,-1(5)	return back to the caller
125: LDA 7,109(7)	jump forward to finale
* processing function: main
236: ST 0,-1(5)	save return address
* -> SimpleVar
* looking up id: i
237: LDA 0,-2(5)	load id address
* <- id
238: ST 0,-4(5)	op: push left
* <- SimpleVar
239: LDC 0,0(0)	load const(0) <- constant
240: ST 0,-5(5)	load const(0) <- constant
241: LD 0,-4(5)	load address of lhs into ac
242: LD 1,-5(5)	load rhs constant into ac1
243: ST 1,0(0)	storing rhs constant into address of lhs
244: ST 1,-3(5)	storing rhs constant into offet of assignExp
* -> while
* -> SimpleVar
245: LD 0,-2(5)	load value of var into AC
246: ST 0,-4(5)	 <- constant
* <- SimpleVar
247: LDC 0,10(0)	load const(10) <- constant
248: ST 0,-5(5)	load const(10) <- constant
249: LD 0,-4(5)	load lhs value into ac
250: LD 1,-5(5)	load rhs value into ac1
251: SUB 0,0,1	 sub values of ac and ac1 into ac
252: JLT 0,2(7)	br if true
253: LDC 0,0(0)	false case
254: LDA 7,1(7)	unconditional jmp
255: LDC 0,1(0)	true case
* -> IndexVar
* -> SimpleVar
257: LD 0,-2(5)	load value of var into AC
258: ST 0,-5(5)	 <- constant
* <- SimpleVar
* looking up id: x
259: LDA 0,-9(6)	load id address
260: ST 0,-4(5)	store array addr
261: LD 0,-5(5)	load value of index into ac
262: LD 1,-4(5)	load array base addr
263: ADD 0,1,0	add offset + index
264: ST 0,-4(5)	store arg val
* -> IndexVar
* -> CallExp
265: ST 5,-5(5)	* store current fp
266: LDA 5,-5(5)	* push new frame
267: LDA 0,1(7)	* save return in ac
268: LDA 7,-265(7)	* relative jump to input function entry
269: LD 5,0(5)	 * pop current frame
* <- CallExp
270: ST 0,-5(5)	load user input
271: LD 0,-4(5)	load address of lhs into ac
272: LD 1,-5(5)	load rhs constant into ac1
273: ST 1,0(0)	storing rhs constant into address of lhs
274: ST 1,-3(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
* looking up id: i
275: LDA 0,-2(5)	load id address
* <- id
276: ST 0,-4(5)	op: push left
* <- SimpleVar
* -> SimpleVar
277: LD 0,-2(5)	load value of var into AC
278: ST 0,-6(5)	 <- constant
* <- SimpleVar
279: LDC 0,1(0)	load const(1) <- constant
280: ST 0,-7(5)	load const(1) <- constant
281: LD 0,-6(5)	load lhs value into ac
282: LD 1,-7(5)	load rhs value into ac1
283: ADD 0,0,1	add values of ac and ac1 into ac
284: ST 0,-5(5)	storing rhs constant into address of lhs
285: LD 0,-4(5)	load address of lhs into ac
286: LD 1,-5(5)	load rhs constant into ac1
287: ST 1,0(0)	storing rhs constant into address of lhs
288: ST 1,-3(5)	storing rhs constant into offet of assignExp
289: LDA 7,-45(7)	while: absolute jmp to test
256: JEQ 0,33(7)	while: jmp to end
* <- while
* -> CallExp
290: LDC 0,0(0)	load const(0) <- constant
291: ST 0,-5(5)	load const(0) <- constant
292: LDC 0,10(0)	load const(10) <- constant
293: ST 0,-6(5)	load const(10) <- constant
294: ST 5,-3(5)	* store current fp
295: LDA 5,-3(5)	* push new frame
296: LDA 0,1(7)	* save return in ac
297: LDA 7,-172(7)	* relative jump to function entry
298: LD 5,0(5)	 * pop current frame
* <- CallExp
299: ST 0,-3(5)	load user input
* -> SimpleVar
* looking up id: i
300: LDA 0,-2(5)	load id address
* <- id
301: ST 0,-4(5)	op: push left
* <- SimpleVar
302: LDC 0,0(0)	load const(0) <- constant
303: ST 0,-5(5)	load const(0) <- constant
304: LD 0,-4(5)	load address of lhs into ac
305: LD 1,-5(5)	load rhs constant into ac1
306: ST 1,0(0)	storing rhs constant into address of lhs
307: ST 1,-3(5)	storing rhs constant into offet of assignExp
* -> while
* -> SimpleVar
308: LD 0,-2(5)	load value of var into AC
309: ST 0,-4(5)	 <- constant
* <- SimpleVar
310: LDC 0,10(0)	load const(10) <- constant
311: ST 0,-5(5)	load const(10) <- constant
312: LD 0,-4(5)	load lhs value into ac
313: LD 1,-5(5)	load rhs value into ac1
314: SUB 0,0,1	 sub values of ac and ac1 into ac
315: JLT 0,2(7)	br if true
316: LDC 0,0(0)	false case
317: LDA 7,1(7)	unconditional jmp
318: LDC 0,1(0)	true case
* -> CallExp
* -> IndexVar
* -> SimpleVar
320: LD 0,-2(5)	load value of var into AC
321: ST 0,-6(5)	 <- constant
* <- SimpleVar
322: LDA 0,-9(6)	load id address
323: ST 0,-5(5)	store array addr
324: LD 0,-6(5)	load value of index into ac
325: LD 1,-5(5)	load array base addr
326: ADD 0,1,0	add offset + index
327: LD 0,0(0)	load value at array index 
328: ST 0,-5(5)	store arg val
* -> IndexVar
329: ST 5,-3(5)	* store current fp
330: LDA 5,-3(5)	* push new frame
331: LDA 0,1(7)	* save return in ac
332: LDA 7,-326(7)	* relative jump to output function entry
333: LD 5,0(5)	 * pop current frame
* <- CallExp
334: ST 0,-3(5)	load user input
* -> SimpleVar
* looking up id: i
335: LDA 0,-2(5)	load id address
* <- id
336: ST 0,-4(5)	op: push left
* <- SimpleVar
* -> SimpleVar
337: LD 0,-2(5)	load value of var into AC
338: ST 0,-6(5)	 <- constant
* <- SimpleVar
339: LDC 0,1(0)	load const(1) <- constant
340: ST 0,-7(5)	load const(1) <- constant
341: LD 0,-6(5)	load lhs value into ac
342: LD 1,-7(5)	load rhs value into ac1
343: ADD 0,0,1	add values of ac and ac1 into ac
344: ST 0,-5(5)	storing rhs constant into address of lhs
345: LD 0,-4(5)	load address of lhs into ac
346: LD 1,-5(5)	load rhs constant into ac1
347: ST 1,0(0)	storing rhs constant into address of lhs
348: ST 1,-3(5)	storing rhs constant into offet of assignExp
349: LDA 7,-42(7)	while: absolute jmp to test
319: JEQ 0,30(7)	while: jmp to end
* <- while
350: LD 7,-1(5)	return back to the caller
235: LDA 7,115(7)	jump forward to finale
351: ST 5,-10(5)	push ofp
352: LDA 5,-10(5)	push frame
353: LDA 0,1(7)	load ac with ret ptr
354: LDA 7,-119(7)	jump to main loc
355: LD 5,0(5)	pop frame
356: HALT 0,0,0	
