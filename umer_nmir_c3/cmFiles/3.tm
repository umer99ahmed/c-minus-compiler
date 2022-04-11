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
28: JLT 0,1(7)	halt if subscript < 0
29: LDA 7,1(7)	absolute jump if not
30: HALT 0,0,0	
31: LDC 1,9(0)	size into ac1
32: SUB 0,1,0	sub size - index
33: JLT 0,1(7)	halt if subscript < 0
34: LDA 7,1(7)	absolute jump if not
35: HALT 0,0,0	
36: LD 0,-10(5)	load value of index into ac
37: LD 1,-9(5)	load array base addr
38: ADD 0,1,0	add offset + index
39: LD 0,0(0)	load value at array index 
40: ST 0,-9(5)	store arg val
* -> IndexVar
41: LD 0,-8(5)	load address of lhs into ac
42: LD 1,-9(5)	load rhs constant into ac1
43: ST 1,0(0)	storing rhs constant into address of lhs
44: ST 1,-7(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
* looking up id: i
45: LDA 0,-4(5)	load id address
* <- id
46: ST 0,-8(5)	op: push left
* <- SimpleVar
* -> SimpleVar
47: LD 0,-2(5)	load value of var into AC
48: ST 0,-10(5)	 <- constant
* <- SimpleVar
49: LDC 0,1(0)	load const(1) <- constant
50: ST 0,-11(5)	load const(1) <- constant
51: LD 0,-10(5)	load lhs value into ac
52: LD 1,-11(5)	load rhs value into ac1
53: ADD 0,0,1	add values of ac and ac1 into ac
54: ST 0,-9(5)	storing rhs constant into address of lhs
55: LD 0,-8(5)	load address of lhs into ac
56: LD 1,-9(5)	load rhs constant into ac1
57: ST 1,0(0)	storing rhs constant into address of lhs
58: ST 1,-7(5)	storing rhs constant into offet of assignExp
* -> while
* -> SimpleVar
59: LD 0,-4(5)	load value of var into AC
60: ST 0,-8(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
61: LD 0,-3(5)	load value of var into AC
62: ST 0,-9(5)	 <- constant
* <- SimpleVar
63: LD 0,-8(5)	load lhs value into ac
64: LD 1,-9(5)	load rhs value into ac1
65: SUB 0,0,1	 sub values of ac and ac1 into ac
66: JLT 0,2(7)	br if true
67: LDC 0,0(0)	false case
68: LDA 7,1(7)	unconditional jmp
69: LDC 0,1(0)	true case
* -> if
* -> IndexVar
* -> SimpleVar
71: LD 0,-4(5)	load value of var into AC
72: ST 0,-9(5)	 <- constant
* <- SimpleVar
73: LDA 0,-9(6)	load id address
74: ST 0,-8(5)	store array addr
75: LD 0,-9(5)	load value of index into ac
76: JLT 0,1(7)	halt if subscript < 0
77: LDA 7,1(7)	absolute jump if not
78: HALT 0,0,0	
79: LDC 1,9(0)	size into ac1
80: SUB 0,1,0	sub size - index
81: JLT 0,1(7)	halt if subscript < 0
82: LDA 7,1(7)	absolute jump if not
83: HALT 0,0,0	
84: LD 0,-9(5)	load value of index into ac
85: LD 1,-8(5)	load array base addr
86: ADD 0,1,0	add offset + index
87: LD 0,0(0)	load value at array index 
88: ST 0,-8(5)	store arg val
* -> IndexVar
* -> SimpleVar
89: LD 0,-5(5)	load value of var into AC
90: ST 0,-9(5)	 <- constant
* <- SimpleVar
91: LD 0,-8(5)	load lhs value into ac
92: LD 1,-9(5)	load rhs value into ac1
93: SUB 0,0,1	 sub values of ac and ac1 into ac
94: JLT 0,2(7)	br if true
95: LDC 0,0(0)	false case
96: LDA 7,1(7)	unconditional jmp
97: LDC 0,1(0)	true case
* -> SimpleVar
* looking up id: a
99: LDA 0,-5(5)	load id address
* <- id
100: ST 0,-8(5)	op: push left
* <- SimpleVar
* -> IndexVar
* -> SimpleVar
101: LD 0,-4(5)	load value of var into AC
102: ST 0,-10(5)	 <- constant
* <- SimpleVar
103: LDA 0,-9(6)	load id address
104: ST 0,-9(5)	store array addr
105: LD 0,-10(5)	load value of index into ac
106: JLT 0,1(7)	halt if subscript < 0
107: LDA 7,1(7)	absolute jump if not
108: HALT 0,0,0	
109: LDC 1,9(0)	size into ac1
110: SUB 0,1,0	sub size - index
111: JLT 0,1(7)	halt if subscript < 0
112: LDA 7,1(7)	absolute jump if not
113: HALT 0,0,0	
114: LD 0,-10(5)	load value of index into ac
115: LD 1,-9(5)	load array base addr
116: ADD 0,1,0	add offset + index
117: LD 0,0(0)	load value at array index 
118: ST 0,-9(5)	store arg val
* -> IndexVar
119: LD 0,-8(5)	load address of lhs into ac
120: LD 1,-9(5)	load rhs constant into ac1
121: ST 1,0(0)	storing rhs constant into address of lhs
122: ST 1,-7(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
* looking up id: k
123: LDA 0,-6(5)	load id address
* <- id
124: ST 0,-8(5)	op: push left
* <- SimpleVar
* -> SimpleVar
125: LD 0,-4(5)	load value of var into AC
126: ST 0,-9(5)	 <- constant
* <- SimpleVar
127: LD 0,-8(5)	load address of lhs into ac
128: LD 1,-9(5)	load rhs constant into ac1
129: ST 1,0(0)	storing rhs constant into address of lhs
130: ST 1,-7(5)	storing rhs constant into offet of assignExp
98: JEQ 0,33(7)	jump to else
131: LDA 7,0(7)	unconditional jump to end
* <- if
* -> SimpleVar
* looking up id: i
132: LDA 0,-4(5)	load id address
* <- id
133: ST 0,-8(5)	op: push left
* <- SimpleVar
* -> SimpleVar
134: LD 0,-4(5)	load value of var into AC
135: ST 0,-10(5)	 <- constant
* <- SimpleVar
136: LDC 0,1(0)	load const(1) <- constant
137: ST 0,-11(5)	load const(1) <- constant
138: LD 0,-10(5)	load lhs value into ac
139: LD 1,-11(5)	load rhs value into ac1
140: ADD 0,0,1	add values of ac and ac1 into ac
141: ST 0,-9(5)	storing rhs constant into address of lhs
142: LD 0,-8(5)	load address of lhs into ac
143: LD 1,-9(5)	load rhs constant into ac1
144: ST 1,0(0)	storing rhs constant into address of lhs
145: ST 1,-7(5)	storing rhs constant into offet of assignExp
146: LDA 7,-88(7)	while: absolute jmp to test
70: JEQ 0,76(7)	while: jmp to end
* <- while
* -> SimpleVar
147: LD 0,-6(5)	load value of var into AC
148: ST 0,-7(5)	 <- constant
* <- SimpleVar
149: LD 0,-7(5)	load return value into ac
150: LD 7,-1(5)	return back to the caller
151: LD 7,-1(5)	return back to the caller
11: LDA 7,140(7)	jump forward to finale
* processing function: sort
153: ST 0,-1(5)	save return address
* -> SimpleVar
* looking up id: i
154: LDA 0,-4(5)	load id address
* <- id
155: ST 0,-7(5)	op: push left
* <- SimpleVar
* -> SimpleVar
156: LD 0,-2(5)	load value of var into AC
157: ST 0,-8(5)	 <- constant
* <- SimpleVar
158: LD 0,-7(5)	load address of lhs into ac
159: LD 1,-8(5)	load rhs constant into ac1
160: ST 1,0(0)	storing rhs constant into address of lhs
161: ST 1,-6(5)	storing rhs constant into offet of assignExp
* -> while
* -> SimpleVar
162: LD 0,-4(5)	load value of var into AC
163: ST 0,-7(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
164: LD 0,-3(5)	load value of var into AC
165: ST 0,-9(5)	 <- constant
* <- SimpleVar
166: LDC 0,1(0)	load const(1) <- constant
167: ST 0,-10(5)	load const(1) <- constant
168: LD 0,-9(5)	load lhs value into ac
169: LD 1,-10(5)	load rhs value into ac1
170: SUB 0,0,1	sub values of ac and ac1 into ac
171: ST 0,-8(5)	storing rhs constant into address of lhs
172: LD 0,-7(5)	load lhs value into ac
173: LD 1,-8(5)	load rhs value into ac1
174: SUB 0,0,1	 sub values of ac and ac1 into ac
175: JLT 0,2(7)	br if true
176: LDC 0,0(0)	false case
177: LDA 7,1(7)	unconditional jmp
178: LDC 0,1(0)	true case
* -> SimpleVar
* looking up id: k
180: LDA 0,-5(5)	load id address
* <- id
181: ST 0,-8(5)	op: push left
* <- SimpleVar
* -> CallExp
* -> SimpleVar
182: LD 0,-4(5)	load value of var into AC
183: ST 0,-11(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
184: LD 0,-3(5)	load value of var into AC
185: ST 0,-12(5)	 <- constant
* <- SimpleVar
186: ST 5,-9(5)	* store current fp
187: LDA 5,-9(5)	* push new frame
188: LDA 0,1(7)	* save return in ac
189: LDA 7,-178(7)	* relative jump to function entry
190: LD 5,0(5)	 * pop current frame
* <- CallExp
191: ST 0,-9(5)	load user input
192: LD 0,-8(5)	load address of lhs into ac
193: LD 1,-9(5)	load rhs constant into ac1
194: ST 1,0(0)	storing rhs constant into address of lhs
195: ST 1,-7(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
* looking up id: t
196: LDA 0,-6(5)	load id address
* <- id
197: ST 0,-8(5)	op: push left
* <- SimpleVar
* -> IndexVar
* -> SimpleVar
198: LD 0,-5(5)	load value of var into AC
199: ST 0,-10(5)	 <- constant
* <- SimpleVar
200: LDA 0,-9(6)	load id address
201: ST 0,-9(5)	store array addr
202: LD 0,-10(5)	load value of index into ac
203: JLT 0,1(7)	halt if subscript < 0
204: LDA 7,1(7)	absolute jump if not
205: HALT 0,0,0	
206: LDC 1,9(0)	size into ac1
207: SUB 0,1,0	sub size - index
208: JLT 0,1(7)	halt if subscript < 0
209: LDA 7,1(7)	absolute jump if not
210: HALT 0,0,0	
211: LD 0,-10(5)	load value of index into ac
212: LD 1,-9(5)	load array base addr
213: ADD 0,1,0	add offset + index
214: LD 0,0(0)	load value at array index 
215: ST 0,-9(5)	store arg val
* -> IndexVar
216: LD 0,-8(5)	load address of lhs into ac
217: LD 1,-9(5)	load rhs constant into ac1
218: ST 1,0(0)	storing rhs constant into address of lhs
219: ST 1,-7(5)	storing rhs constant into offet of assignExp
* -> IndexVar
* -> SimpleVar
220: LD 0,-5(5)	load value of var into AC
221: ST 0,-9(5)	 <- constant
* <- SimpleVar
* looking up id: x
222: LDA 0,-9(6)	load id address
223: ST 0,-8(5)	store array addr
224: LD 0,-9(5)	load value of index into ac
225: JLT 0,1(7)	halt if subscript < 0
226: LDA 7,1(7)	absolute jump if not
227: HALT 0,0,0	
228: LD 1,-8(5)	load array base addr
229: ADD 0,1,0	add offset + index
230: ST 0,-8(5)	store arg val
* -> IndexVar
* -> IndexVar
* -> SimpleVar
231: LD 0,-4(5)	load value of var into AC
232: ST 0,-10(5)	 <- constant
* <- SimpleVar
233: LDA 0,-9(6)	load id address
234: ST 0,-9(5)	store array addr
235: LD 0,-10(5)	load value of index into ac
236: JLT 0,1(7)	halt if subscript < 0
237: LDA 7,1(7)	absolute jump if not
238: HALT 0,0,0	
239: LDC 1,9(0)	size into ac1
240: SUB 0,1,0	sub size - index
241: JLT 0,1(7)	halt if subscript < 0
242: LDA 7,1(7)	absolute jump if not
243: HALT 0,0,0	
244: LD 0,-10(5)	load value of index into ac
245: LD 1,-9(5)	load array base addr
246: ADD 0,1,0	add offset + index
247: LD 0,0(0)	load value at array index 
248: ST 0,-9(5)	store arg val
* -> IndexVar
249: LD 0,-8(5)	load address of lhs into ac
250: LD 1,-9(5)	load rhs constant into ac1
251: ST 1,0(0)	storing rhs constant into address of lhs
252: ST 1,-7(5)	storing rhs constant into offet of assignExp
* -> IndexVar
* -> SimpleVar
253: LD 0,-4(5)	load value of var into AC
254: ST 0,-9(5)	 <- constant
* <- SimpleVar
* looking up id: x
255: LDA 0,-9(6)	load id address
256: ST 0,-8(5)	store array addr
257: LD 0,-9(5)	load value of index into ac
258: JLT 0,1(7)	halt if subscript < 0
259: LDA 7,1(7)	absolute jump if not
260: HALT 0,0,0	
261: LD 1,-8(5)	load array base addr
262: ADD 0,1,0	add offset + index
263: ST 0,-8(5)	store arg val
* -> IndexVar
* -> SimpleVar
264: LD 0,-6(5)	load value of var into AC
265: ST 0,-9(5)	 <- constant
* <- SimpleVar
266: LD 0,-8(5)	load address of lhs into ac
267: LD 1,-9(5)	load rhs constant into ac1
268: ST 1,0(0)	storing rhs constant into address of lhs
269: ST 1,-7(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
* looking up id: i
270: LDA 0,-4(5)	load id address
* <- id
271: ST 0,-8(5)	op: push left
* <- SimpleVar
* -> SimpleVar
272: LD 0,-4(5)	load value of var into AC
273: ST 0,-10(5)	 <- constant
* <- SimpleVar
274: LDC 0,1(0)	load const(1) <- constant
275: ST 0,-11(5)	load const(1) <- constant
276: LD 0,-10(5)	load lhs value into ac
277: LD 1,-11(5)	load rhs value into ac1
278: ADD 0,0,1	add values of ac and ac1 into ac
279: ST 0,-9(5)	storing rhs constant into address of lhs
280: LD 0,-8(5)	load address of lhs into ac
281: LD 1,-9(5)	load rhs constant into ac1
282: ST 1,0(0)	storing rhs constant into address of lhs
283: ST 1,-7(5)	storing rhs constant into offet of assignExp
284: LDA 7,-123(7)	while: absolute jmp to test
179: JEQ 0,105(7)	while: jmp to end
* <- while
285: LD 7,-1(5)	return back to the caller
152: LDA 7,133(7)	jump forward to finale
* processing function: main
287: ST 0,-1(5)	save return address
* -> SimpleVar
* looking up id: i
288: LDA 0,-2(5)	load id address
* <- id
289: ST 0,-4(5)	op: push left
* <- SimpleVar
290: LDC 0,0(0)	load const(0) <- constant
291: ST 0,-5(5)	load const(0) <- constant
292: LD 0,-4(5)	load address of lhs into ac
293: LD 1,-5(5)	load rhs constant into ac1
294: ST 1,0(0)	storing rhs constant into address of lhs
295: ST 1,-3(5)	storing rhs constant into offet of assignExp
* -> while
* -> SimpleVar
296: LD 0,-2(5)	load value of var into AC
297: ST 0,-4(5)	 <- constant
* <- SimpleVar
298: LDC 0,10(0)	load const(10) <- constant
299: ST 0,-5(5)	load const(10) <- constant
300: LD 0,-4(5)	load lhs value into ac
301: LD 1,-5(5)	load rhs value into ac1
302: SUB 0,0,1	 sub values of ac and ac1 into ac
303: JLT 0,2(7)	br if true
304: LDC 0,0(0)	false case
305: LDA 7,1(7)	unconditional jmp
306: LDC 0,1(0)	true case
* -> IndexVar
* -> SimpleVar
308: LD 0,-2(5)	load value of var into AC
309: ST 0,-5(5)	 <- constant
* <- SimpleVar
* looking up id: x
310: LDA 0,-9(6)	load id address
311: ST 0,-4(5)	store array addr
312: LD 0,-5(5)	load value of index into ac
313: JLT 0,1(7)	halt if subscript < 0
314: LDA 7,1(7)	absolute jump if not
315: HALT 0,0,0	
316: LD 1,-4(5)	load array base addr
317: ADD 0,1,0	add offset + index
318: ST 0,-4(5)	store arg val
* -> IndexVar
* -> CallExp
319: ST 5,-5(5)	* store current fp
320: LDA 5,-5(5)	* push new frame
321: LDA 0,1(7)	* save return in ac
322: LDA 7,-319(7)	* relative jump to input function entry
323: LD 5,0(5)	 * pop current frame
* <- CallExp
324: ST 0,-5(5)	load user input
325: LD 0,-4(5)	load address of lhs into ac
326: LD 1,-5(5)	load rhs constant into ac1
327: ST 1,0(0)	storing rhs constant into address of lhs
328: ST 1,-3(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
* looking up id: i
329: LDA 0,-2(5)	load id address
* <- id
330: ST 0,-4(5)	op: push left
* <- SimpleVar
* -> SimpleVar
331: LD 0,-2(5)	load value of var into AC
332: ST 0,-6(5)	 <- constant
* <- SimpleVar
333: LDC 0,1(0)	load const(1) <- constant
334: ST 0,-7(5)	load const(1) <- constant
335: LD 0,-6(5)	load lhs value into ac
336: LD 1,-7(5)	load rhs value into ac1
337: ADD 0,0,1	add values of ac and ac1 into ac
338: ST 0,-5(5)	storing rhs constant into address of lhs
339: LD 0,-4(5)	load address of lhs into ac
340: LD 1,-5(5)	load rhs constant into ac1
341: ST 1,0(0)	storing rhs constant into address of lhs
342: ST 1,-3(5)	storing rhs constant into offet of assignExp
343: LDA 7,-48(7)	while: absolute jmp to test
307: JEQ 0,36(7)	while: jmp to end
* <- while
* -> CallExp
344: LDC 0,0(0)	load const(0) <- constant
345: ST 0,-5(5)	load const(0) <- constant
346: LDC 0,10(0)	load const(10) <- constant
347: ST 0,-6(5)	load const(10) <- constant
348: ST 5,-3(5)	* store current fp
349: LDA 5,-3(5)	* push new frame
350: LDA 0,1(7)	* save return in ac
351: LDA 7,-199(7)	* relative jump to function entry
352: LD 5,0(5)	 * pop current frame
* <- CallExp
353: ST 0,-3(5)	load user input
* -> SimpleVar
* looking up id: i
354: LDA 0,-2(5)	load id address
* <- id
355: ST 0,-4(5)	op: push left
* <- SimpleVar
356: LDC 0,0(0)	load const(0) <- constant
357: ST 0,-5(5)	load const(0) <- constant
358: LD 0,-4(5)	load address of lhs into ac
359: LD 1,-5(5)	load rhs constant into ac1
360: ST 1,0(0)	storing rhs constant into address of lhs
361: ST 1,-3(5)	storing rhs constant into offet of assignExp
* -> while
* -> SimpleVar
362: LD 0,-2(5)	load value of var into AC
363: ST 0,-4(5)	 <- constant
* <- SimpleVar
364: LDC 0,10(0)	load const(10) <- constant
365: ST 0,-5(5)	load const(10) <- constant
366: LD 0,-4(5)	load lhs value into ac
367: LD 1,-5(5)	load rhs value into ac1
368: SUB 0,0,1	 sub values of ac and ac1 into ac
369: JLT 0,2(7)	br if true
370: LDC 0,0(0)	false case
371: LDA 7,1(7)	unconditional jmp
372: LDC 0,1(0)	true case
* -> CallExp
* -> IndexVar
* -> SimpleVar
374: LD 0,-2(5)	load value of var into AC
375: ST 0,-6(5)	 <- constant
* <- SimpleVar
376: LDA 0,-9(6)	load id address
377: ST 0,-5(5)	store array addr
378: LD 0,-6(5)	load value of index into ac
379: JLT 0,1(7)	halt if subscript < 0
380: LDA 7,1(7)	absolute jump if not
381: HALT 0,0,0	
382: LDC 1,9(0)	size into ac1
383: SUB 0,1,0	sub size - index
384: JLT 0,1(7)	halt if subscript < 0
385: LDA 7,1(7)	absolute jump if not
386: HALT 0,0,0	
387: LD 0,-6(5)	load value of index into ac
388: LD 1,-5(5)	load array base addr
389: ADD 0,1,0	add offset + index
390: LD 0,0(0)	load value at array index 
391: ST 0,-5(5)	store arg val
* -> IndexVar
392: ST 5,-3(5)	* store current fp
393: LDA 5,-3(5)	* push new frame
394: LDA 0,1(7)	* save return in ac
395: LDA 7,-389(7)	* relative jump to output function entry
396: LD 5,0(5)	 * pop current frame
* <- CallExp
397: ST 0,-3(5)	load user input
* -> SimpleVar
* looking up id: i
398: LDA 0,-2(5)	load id address
* <- id
399: ST 0,-4(5)	op: push left
* <- SimpleVar
* -> SimpleVar
400: LD 0,-2(5)	load value of var into AC
401: ST 0,-6(5)	 <- constant
* <- SimpleVar
402: LDC 0,1(0)	load const(1) <- constant
403: ST 0,-7(5)	load const(1) <- constant
404: LD 0,-6(5)	load lhs value into ac
405: LD 1,-7(5)	load rhs value into ac1
406: ADD 0,0,1	add values of ac and ac1 into ac
407: ST 0,-5(5)	storing rhs constant into address of lhs
408: LD 0,-4(5)	load address of lhs into ac
409: LD 1,-5(5)	load rhs constant into ac1
410: ST 1,0(0)	storing rhs constant into address of lhs
411: ST 1,-3(5)	storing rhs constant into offet of assignExp
412: LDA 7,-51(7)	while: absolute jmp to test
373: JEQ 0,39(7)	while: jmp to end
* <- while
413: LD 7,-1(5)	return back to the caller
286: LDA 7,127(7)	jump forward to finale
414: ST 5,-10(5)	push ofp
415: LDA 5,-10(5)	push frame
416: LDA 0,1(7)	load ac with ret ptr
417: LDA 7,-131(7)	jump to main loc
418: LD 5,0(5)	pop frame
419: HALT 0,0,0	
