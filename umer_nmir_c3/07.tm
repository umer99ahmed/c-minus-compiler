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
13: LDA 0,0(6)	load id address
* <- id
14: ST 0,-3(5)	op: push left
* <- SimpleVar
15: LDC 0,0(0)	load const(0) <- constant
16: ST 0,-4(5)	load const(0) <- constant
17: LD 0,-3(5)	load address of lhs into ac
18: LD 1,-4(5)	load rhs constant into ac1
19: ST 1,0(0)	storing rhs constant into address of lhs
20: ST 1,0(6)	storing rhs constant into offet of assignExp
* -> if
* -> SimpleVar
21: LD 0,0(6)	load value of var into AC
22: ST 0,-3(5)	 <- constant
* <- SimpleVar
23: LDC 0,0(0)	load const(0) <- constant
24: ST 0,-4(5)	load const(0) <- constant
25: LD 0,-3(5)	load lhs value into ac
26: LD 1,-4(5)	load rhs value into ac1
27: SUB 0,0,1	 sub values of ac and ac1 into ac
28: JEQ 0,2(7)	br if true
29: LDC 0,0(0)	false case
30: LDA 7,1(7)	unconditional jmp
31: LDC 0,1(0)	true case
* -> SimpleVar
* looking up id: x
33: LDA 0,0(6)	load id address
* <- id
34: ST 0,-3(5)	op: push left
* <- SimpleVar
35: LDC 0,5(0)	load const(5) <- constant
36: ST 0,-4(5)	load const(5) <- constant
37: LD 0,-3(5)	load address of lhs into ac
38: LD 1,-4(5)	load rhs constant into ac1
39: ST 1,0(0)	storing rhs constant into address of lhs
40: ST 1,0(6)	storing rhs constant into offet of assignExp
32: JEQ 0,9(7)	jump to else
41: LDA 7,0(7)	unconditional jump to end
* <- if
* -> CallExp
* -> SimpleVar
42: LD 0,0(6)	load value of var into AC
43: ST 0,-2(5)	 <- constant
* <- SimpleVar
44: ST 0,-4(5)	Storing value of arg 1 into (-2)fp
45: ST 5,-2(5)	* store current fp
46: LDA 5,-2(5)	* push new frame
47: LDA 0,1(7)	* save return in ac
48: LDA 7,-42(7)	* relative jump to output function entry
49: LD 5,0(5)	 * pop current frame
* <- CallExp
50: ST 0,-2(5)	load user input
51: LD 7,-1(5)	return back to the caller
11: LDA 7,40(7)	jump forward to finale
52: ST 5,-1(5)	push ofp
53: LDA 5,-1(5)	push frame
54: LDA 0,1(7)	load ac with ret ptr
55: LDA 7,-44(7)	jump to main loc
56: LD 5,0(5)	pop frame
57: HALT 0,0,0	
