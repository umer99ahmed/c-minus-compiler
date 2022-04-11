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
* looking up id: x
13: LDA 0,-2(5)	load id address
* <- id
14: ST 0,-4(5)	op: push left
* <- SimpleVar
* -> CallExp
15: ST 5,-5(5)	* store current fp
16: LDA 5,-5(5)	* push new frame
17: LDA 0,1(7)	* save return in ac
18: LDA 7,-15(7)	* relative jump to input function entry
19: LD 5,0(5)	 * pop current frame
* <- CallExp
20: ST 0,-5(5)	load user input
21: LD 0,-4(5)	load address of lhs into ac
22: LD 1,-5(5)	load rhs constant into ac1
23: ST 1,0(0)	storing rhs constant into address of lhs
24: ST 1,-3(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
* looking up id: fac
25: LDA 0,0(6)	load id address
* <- id
26: ST 0,-4(5)	op: push left
* <- SimpleVar
27: LDC 0,1(0)	load const(1) <- constant
28: ST 0,-5(5)	load const(1) <- constant
29: LD 0,-4(5)	load address of lhs into ac
30: LD 1,-5(5)	load rhs constant into ac1
31: ST 1,0(0)	storing rhs constant into address of lhs
32: ST 1,-3(5)	storing rhs constant into offet of assignExp
* -> while
* -> SimpleVar
33: LD 0,-2(5)	load value of var into AC
34: ST 0,-4(5)	 <- constant
* <- SimpleVar
35: LDC 0,1(0)	load const(1) <- constant
36: ST 0,-5(5)	load const(1) <- constant
37: LD 0,-4(5)	load lhs value into ac
38: LD 1,-5(5)	load rhs value into ac1
39: SUB 0,0,1	 sub values of ac and ac1 into ac
40: JGT 0,2(7)	br if true
41: LDC 0,0(0)	false case
42: LDA 7,1(7)	unconditional jmp
43: LDC 0,1(0)	true case
* -> SimpleVar
* looking up id: fac
45: LDA 0,0(6)	load id address
* <- id
46: ST 0,-4(5)	op: push left
* <- SimpleVar
* -> SimpleVar
47: LD 0,0(6)	load value of var into AC
48: ST 0,-6(5)	 <- constant
* <- SimpleVar
* -> SimpleVar
49: LD 0,-2(5)	load value of var into AC
50: ST 0,-7(5)	 <- constant
* <- SimpleVar
51: LD 0,-6(5)	load lhs value into ac
52: LD 1,-7(5)	load rhs value into ac1
53: MUL 0,0,1	mul values of ac and ac1 into ac
54: ST 0,-5(5)	storing rhs constant into address of lhs
55: LD 0,-4(5)	load address of lhs into ac
56: LD 1,-5(5)	load rhs constant into ac1
57: ST 1,0(0)	storing rhs constant into address of lhs
58: ST 1,-3(5)	storing rhs constant into offet of assignExp
* -> SimpleVar
* looking up id: x
59: LDA 0,-2(5)	load id address
* <- id
60: ST 0,-4(5)	op: push left
* <- SimpleVar
* -> SimpleVar
61: LD 0,-2(5)	load value of var into AC
62: ST 0,-6(5)	 <- constant
* <- SimpleVar
63: LDC 0,1(0)	load const(1) <- constant
64: ST 0,-7(5)	load const(1) <- constant
65: LD 0,-6(5)	load lhs value into ac
66: LD 1,-7(5)	load rhs value into ac1
67: SUB 0,0,1	sub values of ac and ac1 into ac
68: ST 0,-5(5)	storing rhs constant into address of lhs
69: LD 0,-4(5)	load address of lhs into ac
70: LD 1,-5(5)	load rhs constant into ac1
71: ST 1,0(0)	storing rhs constant into address of lhs
72: ST 1,-3(5)	storing rhs constant into offet of assignExp
73: LDA 7,-41(7)	while: absolute jmp to test
44: JEQ 0,29(7)	while: jmp to end
* <- while
* -> CallExp
* -> SimpleVar
74: LD 0,0(6)	load value of var into AC
75: ST 0,-5(5)	 <- constant
* <- SimpleVar
76: ST 5,-3(5)	* store current fp
77: LDA 5,-3(5)	* push new frame
78: LDA 0,1(7)	* save return in ac
79: LDA 7,-73(7)	* relative jump to output function entry
80: LD 5,0(5)	 * pop current frame
* <- CallExp
81: ST 0,-3(5)	load user input
82: LD 7,-1(5)	return back to the caller
11: LDA 7,71(7)	jump forward to finale
83: ST 5,-1(5)	push ofp
84: LDA 5,-1(5)	push frame
85: LDA 0,1(7)	load ac with ret ptr
86: LDA 7,-75(7)	jump to main loc
87: LD 5,0(5)	pop frame
88: HALT 0,0,0	
