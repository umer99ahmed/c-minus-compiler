import absyn.*;
import java.util.HashMap;
import java.util.ArrayList;

public class CodeGenerator implements AbsynVisitor {
  int mainEntry;
  int globalOffset = 0; // points to bottom of global stackframe (gp register points to top)
  // constructor for initialization and all emitting routines
  static int emitLoc = 0; // points to the current instruction we are generating (may go back to an
                          // earlier location for backpatching)
  static int highEmitLoc = 0; // points to the next available space so that we can continue adding
                              // new instructions
  final int ac = 0;
  final int ac1 = 1;
  final int fp = 5;
  final int gp = 6;
  final int pc = 7;
  final int initFO = -2;
  final int ofpFO = 0;

  /*
   * Returns location of skipped instruction, skips instruction, and matches highEmitLoc (if
   * necessary)
   */
  /* distance = number of instructions to skip (usually 1) */
  private int emitSkip(int distance) {
    int i = emitLoc;
    emitLoc += distance;
    if (highEmitLoc < emitLoc)
      highEmitLoc = emitLoc;
    return i;
  }

  private void emitBackup(int loc) {
    if (loc > highEmitLoc)
      emitComment("BUG in emitBackup", true);
    emitLoc = loc;
  }

  private void emitComment(String comment, boolean isError) {
    if (isError) {
      System.err.println(comment);
    } else {
      System.out.println(comment);
    }
  }

  // Letting emitLoc continue from where it left off after finishing jump instruction
  private void emitRestore() {
    emitLoc = highEmitLoc;
  }

  void emitRM_Abs(String op, int r, int a, String comment) {
    // fprintf( code, "%3d: %5s %d, %d(%d) ", emitLoc, op, r, a - (emitLoc + 1), pc );
    // fprintf( code, "\t%s\n", c );
    System.out.print(emitLoc + ": " + op + " " + r + "," + (a - (emitLoc + 1)) + "(" + pc + ")");
    System.out.println("\t" + comment);
    ++emitLoc;
    if (highEmitLoc < emitLoc)
      highEmitLoc = emitLoc;
  }

  private void emitRO(String op, int r, int s, int t, String comment) {
    // fprintf( code, "%3d: %5s %d, %d, %d", emitLoc, op, r, s, t );
    // fprintf( code, "\t%s\n", c );
    System.out.print(emitLoc + ": " + op + " " + r + "," + s + "," + t);
    System.out.println("\t" + comment);
    ++emitLoc;
    if (highEmitLoc < emitLoc)
      highEmitLoc = emitLoc;
  }

  private void emitRM(String op, int r, int d, int s, String comment) {
    // System.err.println( "%3d: %5s %d, %d(%d)", emitLoc, op, r, d, s );
    System.out.print(emitLoc + ": " + op + " " + r + "," + d + "(" + s + ")");
    // System.err.println( "\t%s\n", c );
    System.out.println("\t" + comment);
    ++emitLoc;
    if (highEmitLoc < emitLoc)
      highEmitLoc = emitLoc;
  }

  public void visit(Absyn trees) { // wrapper for post-order traversal
    System.err.println("CODE GENERATION START!");
    emitComment("* Standard prelude:", false);
    // generate the prelude
    // 0: LD 6, 0(0) load gp with maxaddr
    emitRM("LD", gp, 0, ac, "load up with maxaddr");
    // 1: LDA 5, 0(6) copy gp to fp
    emitRM("LDA", fp, 0, gp, "copy gp to fp");
    // 2: ST 0, 0(0) clear content at loc 0
    emitRM("ST", ac, 0, ac, "clear content at loc 0");

    // generate the i/o routines
    emitComment("* Jump around i/o routines here", false);
    int skippedLoc = emitSkip(1); // stores 3, emitLoc incremented
    emitComment("* code for input routine", false);
    // 4: ST 0,-1(5) store return
    emitRM("ST", ac, -1, fp, "store return");
    // 5: IN 0,0,0 input
    emitRO("IN", 0, 0, 0, "input");

    // 6: LD 7,-1(5) return to caller
    emitRM("LD", pc, -1, fp, "return to caller");
    emitComment("* code for output routine", false);

    // 7: ST 0,-1(5) store return
    emitRM("ST", ac, -1, fp, "store return");
    // 8: LD 0,-2(5) load output value
    emitRM("LD", ac, -2, fp, "load output value");

    // 9: OUT 0,0,0 output
    emitRO("OUT", 0, 0, 0, "input");
    // 10: LD 7,-1(5) return to caller
    emitRM("LD", pc, -1, fp, "return to caller");
    int savedLoc = emitSkip(0);
    emitBackup(skippedLoc);
    // 3: LDA 7,7(7) jump around i/o code
    emitRM_Abs("LDA", pc, savedLoc, "jump around i/o code");
    emitRestore();
    emitComment("* End of standard prelude.", false);


    // call the visit method for DecList
    trees.accept(this, 0, false);
    // visit(trees, 0, false);

    // generate finale

    // 81: ST 5, -1(5) push ofp
    emitRM("ST", fp, globalOffset + 0, fp, "push ofp");
    // 82: LDA 5, -1(5) push frame
    emitRM("LDA", fp, globalOffset, fp, "push frame");
    // 83: LDA 0, 1(7) load ac with ret ptr
    emitRM("LDA", ac, 1, pc, "load ac with ret ptr");
    // 84: LDA 7, -35(7) jump to main loc
    emitRM_Abs("LDA", pc, mainEntry, "jump to main loc");
    // 85: LD 5, 0(5) pop frame
    emitRM("LD", fp, 0, fp, "pop frame");
    // 86: HALT 0, 0, 0
    emitRO("HALT", 0, 0, 0, "");


  } // implement all visit methods in AbsynVisitor

  public void visit(DecList decs, int offset, boolean isAddress) {
    System.err.println("CODE GENERATION DECLIST!");
    while (decs != null) {
      if (decs.head != null) {
        decs.head.accept(this, offset, isAddress);
      }
      decs = decs.tail;
    }

  }

  public void visit(FunctionDec dec, int offset, boolean isAddr) {
    System.err.println("FunctionDec(offset): " + offset);


    // /* code for i/o routines */
    // ...
    // /* code for finale */

    // indent(level);
    System.out.println("* processing function: " + dec.func);

    // System.out.print("12: ST 0, -1(5) save return address\n13: LD 7, -1(5) return back to the
    // caller\n11: LDA 7, 2(7) jump forward to finale\n");
    int skippedLoc = emitSkip(1); // stores 11, emitLoc incremented

    if (dec.func.equals("main")) {
      mainEntry = emitLoc;
    }
    dec.funaddr = emitLoc;
    // 12: ST 0, -1(5) save return address
    emitRM("ST", ac, -1, fp, "save return address");

    // level++;

    // if (dec.result != null) {
    // dec.result.accept(this, level, isAddr);
    // }
    // if (dec.params != null) {
    // dec.params.accept(this, level, isAddr);
    // }
    if (dec.body != null) {
      dec.body.accept(this, offset - 2, isAddr);
    }

    // 13: LD 7, -1(5) return back to the caller
    emitRM("LD", pc, -1, fp, "return back to the caller");
    int savedLoc = emitSkip(0); // 14
    emitBackup(skippedLoc);
    // 11: LDA 7, 2(7) jump forward to finale (might just be something for main)
    emitRM_Abs("LDA", pc, savedLoc, "jump forward to finale");
    emitRestore();
  }

  public void visit(SimpleDec dec, int offset, boolean isAddr) {
    // TODO: how do we set nestLevel? dec.offset would depend on that?
    System.err.println("SimpleDec(offset): " + dec.name + " " + offset);
    // dec.nestLevel = NEST_LEVEL;
    if (dec.nestLevel == 0) {
      dec.offset = globalOffset;// 0
      globalOffset--;// -1
    } else {
      dec.offset = offset;
      // how do we handle fp?
    }

    // indent(level);
    // System.out.println("SimpleDec: " + dec.name);
    // level++;
    // if (dec.typ != null) {
    // dec.typ.accept(this, level, isAddr);
    // }
  }

  public void visit(ArrayDec dec, int offset, boolean isAddr) {
    System.err.println("ArrayDec(offset): " + dec.name + " " + offset);

    if (dec.nestLevel == 0) {
      globalOffset -= dec.size.value;// -10
      dec.offset = globalOffset + 1;// -9
    } else {
      dec.offset = offset - (dec.size.value + 1);
    }


    // indent(level);
    // System.out.println("ArrayDec: " + dec.name);
    // level++;
    // if (dec.typ != null) {
    // dec.typ.accept(this, level, isAddr);
    // }
    // if (dec.size != null) {
    // dec.size.accept(this, level, isAddr);
    // }
  }

  public void visit(CompoundExp exp, int offset, boolean isAddr) {
    System.err.println("CompoundExp(offset): " + offset);

    if (exp.decs != null) {
      exp.decs.accept(this, offset, isAddr);
    }

    /* Update offset to reflect declarations */
    VarDec lastDec = null;
    if (exp.decs != null) {
      while (exp.decs != null) {
        if (exp.decs.head != null) {
          lastDec = exp.decs.head;
        }
        exp.decs = exp.decs.tail;
      }
    }
    if (lastDec != null) {
      offset = lastDec.offset-1;
    }
    System.err.println("OFFSET BEFORE EXPS IN COMPOUNDEXP: " + offset);

    if (exp.exps != null) {
      exp.exps.accept(this, offset, isAddr);
      // 4: ST 0,-1(5) store return
      // emitRM("ST", ac, -1, fp, "store return");
    }

  }

  public void visit(CompoundExp exp, int level, boolean isPreceded, boolean isAddr) {}

  public void visit(VarDecList varDecList, int offset, boolean isAddr) {
    System.err.println("VarDecList(offset): " + offset);

    while (varDecList != null) {
      if (varDecList.head != null) {
        varDecList.head.accept(this, offset, isAddr);
        if (varDecList.head instanceof ArrayDec) {
          offset -= ((ArrayDec) varDecList.head).size.value;
        } else {
          offset--;
        }
      }
      varDecList = varDecList.tail;
    }
    System.err.println("OFFSET IN VARDECLIST AFTER ADDING DECS: " + offset);
  }

  public void visit(ExpList expList, int offset, boolean isAddr) {
    while (expList != null) {
      if (expList.head != null) {
        expList.head.accept(this, offset, isAddr);
      }
      expList = expList.tail;
    }
  }

  public void visit(AssignExp exp, int offset, boolean isAddr) {// -2
    /*
     * looking up id: fac | storing addy of LHS into reg0 22: LDA 0,-3(5) load id address <- id | in
     * the next spot of dMem, store addy of fac? 23: ST 0,-4(5) op: push left -> constant | store
     * '1' into reg0 24: LDC 0,1(0) load const <- constant | load addy of fac into reg1, then store
     * 1 into addy at reg1? which is fac 25: LD 1,-4(5) op: load left 26: ST 0,0(1) assign: store
     * value
     */
    // indent(level);

    // x=2 gp(&x)
    // main opf 0
    // ret -1
    // 2 -2
    // &x(0) -3
    // 2 -4
    System.err.println("AssignExp:");
    // level++;
    if (exp.lhs != null) {
      exp.lhs.accept(this, offset - 1, true);
    }
    if (exp.rhs != null) {
      exp.rhs.accept(this, offset - 2, isAddr);
    }
    // whats going on?
    // 23: LD 0, -4(5)
    emitRM("LD", ac, offset - 1, fp, "load address of lhs into ac");
    // 24: LD 1, -5(5)
    emitRM("LD", ac1, offset - 2, fp, "load rhs constant into ac1");
    // 25: ST 1, 0(0)
    emitRM("ST", ac1, 0, ac, "storing rhs constant into address of lhs");
    // 26: ST 1, -3(5)
    if(((SimpleVar) exp.lhs.variable).relatedDef.nestLevel == 0 ){
      int gpOffset = ((SimpleVar) exp.lhs.variable).relatedDef.offset;
      emitRM("ST", ac1, gpOffset, gp, "storing rhs constant into offet of assignExp"); 
    }else{
      int fpOffset = ((SimpleVar) exp.lhs.variable).relatedDef.offset;
      emitRM("ST", ac1, fpOffset, fp, "storing rhs constant into offet of assignExp"); 
    }


  }

  public void visit(IntExp exp, int offset, boolean isAddr) {
    System.err.println("IntExp:(offset) " + exp.value + " " + offset);
    // 24: LDC 0,2(0) load const <- constant
    emitRM("LDC", ac, exp.value, 0, "load const(" + String.valueOf(exp.value) + ") <- constant");
    // 25: ST 0,-4(5) op: push left -> constant
    emitRM("ST", ac, offset, fp, "load const(" + String.valueOf(exp.value) + ") <- constant");

  }

  public void visit(VarExp exp, int offset, boolean isAddr) {
    System.err.println("VarExp: ");
    if (exp.variable != null) {
      exp.variable.accept(this, offset, isAddr);
    }
  }

  public void visit(SimpleVar var, int offset, boolean isAddr) {
    System.err.println("SimpleVar:(offset) " + var.name + " " + offset);
    int reg = 0;
    reg = var.relatedDef.nestLevel == 0 ? gp : fp;

    if (isAddr) {
      emitComment("* looking up id: " + var.name, false);
      // 37: LDA 0,-3(5) load id address
      emitRM("LDA", ac, var.relatedDef.offset, reg, "load id address");
      // * <- id
      emitComment("* <- id", false);
      // 38: ST 0,-3(5) op: push left
      emitRM("ST", ac, offset, fp, "op: push left");
    } else {
      // LD 0,-3(5) load id value
      emitRM("LD", ac, var.relatedDef.offset, reg, "load value of var into AC");
      //yest
      emitRM("ST", ac, offset, fp, " <- constant");
    } 
  }

  public void visit(CallExp exp, int offset, boolean isAddr) {
    System.err.println("CallExp(offset): " + exp.func + " " + offset);
    if (exp.args != null) {
      // exp.args.accept(this, offset, isAddr);
      // for (int i=0; i < exp.args)

      int i = 0;
      while (exp.args != null) {

        if (exp.args.head != null) {
          exp.args.head.accept(this, offset, false);
          emitRM("ST", ac, offset + initFO + i, fp,
              "Storing value of arg " + (i + 1) + " into " + "(" + (offset + i) + ")fp");
          i--;
        }
        exp.args = exp.args.tail;
      }
      // ST fp, frameOffset+ofpFO (fp) * store current fp
      emitRM("ST", fp, offset + ofpFO, fp, "* store current fp");
      // LDA fp, frameOffset (fp) * push new frame
      emitRM("LDA", fp, offset, fp, "* push new frame");
      // LDA ac, 1 (pc) * save return in ac
      emitRM("LDA", ac, 1, pc, "* save return in ac");
      // LDA pc, ... (pc) * relative jump to function entry
      // if output hardcode else if input hardcode, else get funaddr and calculate offset
      emitRM_Abs("LDA", pc, 7, "* relative jump to function entry");
      // LD fp, ofpFO (fp) * pop current frame
      emitRM("LD", fp, ofpFO, fp, " * pop current frame");
    }
  }


  final static int SPACES = 4;

  private void indent(int level) {
    for (int i = 0; i < level * SPACES; i++)
      System.out.print(" ");
  }



  public void visit(IfExp exp, int level, boolean isAddr) {
    indent(level);
    System.err.println("IfExp:");
    level++;

    if (exp.test != null) {
      exp.test.accept(this, level, isAddr);
    }

    if (exp.thenpart != null) {
      exp.thenpart.accept(this, level, isAddr);
    }

    if (exp.elsepart != null) {
      exp.elsepart.accept(this, level, isAddr);
    }
  }

  public void visit(NameTy typ, int level, boolean isAddr) {
    indent(level);
    if (typ.type == 0) {
      System.out.println("NameTy: int");
    }
    if (typ.type == 1) {
      System.out.println("NameTy: void");
    }
  }

  public void visit(NilExp exp, int level, boolean isAddr) {
    indent(level);
    System.out.println("NilExp: ");
  }

  public void visit(OpExp exp, int level, boolean isAddr) {
    indent(level);
    System.out.print("OpExp:");
    switch (exp.op) {
      case OpExp.PLUS:
        System.out.println(" + ");
        break;
      case OpExp.MINUS:
        System.out.println(" - ");
        break;
      case OpExp.TIMES:
        System.out.println(" * ");
        break;
      case OpExp.OVER:
        System.out.println(" / ");
        break;
      case OpExp.LTEQ:
        System.out.println(" <= ");
        break;
      case OpExp.GTEQ:
        System.out.println(" >= ");
        break;
      case OpExp.EQ:
        System.out.println(" == ");
        break;
      case OpExp.NOTEQ:
        System.out.println(" != ");
        break;
      case OpExp.LT:
        System.out.println(" < ");
        break;
      case OpExp.GT:
        System.out.println(" > ");
        break;
      default:
        System.out.println("Unrecognized operator at line " + exp.row + " and column " + exp.col);
    }
    level++;
    if (exp.left != null) {
      exp.left.accept(this, level, isAddr);
    }
    if (exp.right != null) {
      exp.right.accept(this, level, isAddr);
    }
  }

  public void visit(ReturnExp exp, int level, boolean isAddr) {
    indent(level);
    System.out.println("ReturnExp: ");
    level++;
    if (exp.exp != null) {
      exp.exp.accept(this, level, isAddr);
    }
  }



  public void visit(IndexVar var, int level, boolean isAddr) {
    indent(level);
    System.out.println("IndexVar: " + var.name);
    level++;
    if (var.index != null) {
      var.index.accept(this, level, isAddr);
    }
  }

  public void visit(WhileExp exp, int level, boolean isAddr) {
    indent(level);
    System.out.println("WhileExp:");
    level++;
    if (exp.test != null) {
      exp.test.accept(this, level, isAddr);
    }
    if (exp.body != null) {
      exp.body.accept(this, level, isAddr);
    }
  }


}
