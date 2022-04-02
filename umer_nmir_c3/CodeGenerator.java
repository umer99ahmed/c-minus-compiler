import absyn.*;
import java.util.HashMap;
import java.util.ArrayList;

public class CodeGenerator implements AbsynVisitor {
  int mainEntry;
  int globalOffset; // points to bottom of global stackframe (gp register points to top)
  // constructor for initialization and all emitting routines
  static int emitLoc = 0; // points to the current instruction we are generating (may go back to an earlier location for backpatching)
  static int highEmitLoc = 0; // points to the next available space so that we can continue adding new instructions

  // int emitSkip(int distance) {
  //   int i = emitLoc;
  //   emitLoc += distance;
  //   if (highEmitLoc < emitLoc)
  //     highEmitLoc = emitLoc;
  //   return i;
  // }

  // void emitBackup( int loc ) {
  //   if( loc > highEmitLoc )
  //     emitComment( “BUG in emitBackup” );
  //   emitLoc = loc;
  // }

  // void emitRestore( void ) {
  //   emitLoc = highEmitLoc;
  // }

  // void emitRM_Abs( char *op, int r, int a, char *c ) {
  //     fprintf( code, “%3d: %5s %d, %d(%d) “, emitLoc, op, r, a – (emitLoc + 1), pc );
  //     fprintf( code, “\t%s\n”, c );
  //     ++emitLoc;
  //     if( highEmitLoc < emitLoc )
  //       highEmitLoc = emitLoc;
  // }

  // void emitRO( char *op, int r, int s, int t, char *c ) {
  //   fprintf( code, “%3d: %5s %d, %d, %d”, emitLoc, op, r, s, t );
  //   fprintf( code, “\t%s\n”, c );
  //   ++emitLoc;
  //   if( highEmitLoc < emitLoc )
  //     highEmitLoc = emitLoc;
  // }

  // void emitRM( char *op, int r, int d, int s, char *c ) {
  //   fprintf( code, “%3d: %5s %d, %d(%d)”, emitLoc, op, r, d, s );
  //   fprintf( code, “\t%s\n”, c );
  //   ++emitLoc;
  //   if( highEmitLoc < emitLoc )
  //     highEmitLoc = emitLoc;
  // }

  public void visit(Absyn trees) { // wrapper for post-order traversal
    System.err.println("CODE GENERATION START!");
    // generate the prelude
    // 0: LD 6, 0(0) load gp with maxaddr
    // emitRM(“LD”, gp, 0, ac, “load up with maxaddr”);
    // 1: LDA 5, 0(6) copy gp to fp
    // 2: ST 0, 0(0) clear content at loc 0
    //  System.err.println("0: LD 6, 0(0) load gp with maxaddr");
    //  System.err.println("1: LDA 5, 0(6) copy gp to fp");
    //  System.err.println("2: ST 0, 0(0) clear content at loc 0");
    // generate the i/o routines
    // call the visit method for DecList
    trees.accept(this, 0, false);
    // visit(trees, 0, false);
    // generate finale

  } // implement all visit methods in AbsynVisitor

  public void visit(DecList decs, int offset, boolean isAddress) {
    System.err.println("CODE GENERATION DECLIST!");

  }

  // public void visit( DecList decList, int level, boolean isAddr ){ BEFORE
  // while( decList != null ) {
  // if(decList.head != null){
  // decList.head.accept( this, level, isAddr );
  // }
  // decList = decList.tail;
  // }
  // }



  final static int SPACES = 4;

  private void indent(int level) {
    for (int i = 0; i < level * SPACES; i++)
      System.out.print(" ");
  }

  public void visit(AssignExp exp, int level, boolean isAddr) {
    indent(level);
    System.out.println("AssignExp:");
    level++;
    if (exp.lhs != null) {
      exp.lhs.accept(this, level, isAddr);
    }
    if (exp.rhs != null) {
      exp.rhs.accept(this, level, isAddr);
    }
  }

  public void visit(CallExp exp, int level, boolean isAddr) {
    indent(level);
    System.out.println("CallExp: " + exp.func);
    level++;
    if (exp.args != null) {
      exp.args.accept(this, level, isAddr);
    }

  }

  public void visit(CompoundExp exp, int level, boolean isAddr) {
    indent(level);
    System.out.println("CompoundExp: ");
    level++;
    if (exp.decs != null) {
      exp.decs.accept(this, level, isAddr);
    }

    if (exp.exps != null) {
      exp.exps.accept(this, level, isAddr);
    }

  }

  public void visit(CompoundExp exp, int level, boolean isPreceded, boolean isAddr) {}


  public void visit(ExpList expList, int level, boolean isAddr) {
    while (expList != null) {
      if (expList.head != null) {
        expList.head.accept(this, level, isAddr);
      }
      expList = expList.tail;
    }
  }

  public void visit(FunctionDec dec, int level, boolean isAddr) {
    indent(level);
    System.out.println("FunctionDec: " + dec.func);
    level++;

    if (dec.result != null) {
      dec.result.accept(this, level, isAddr);
    }
    if (dec.params != null) {
      dec.params.accept(this, level, isAddr);
    }
    if (dec.body != null) {
      dec.body.accept(this, level, isAddr);
    }
  }

  public void visit(IfExp exp, int level, boolean isAddr) {
    indent(level);
    System.out.println("IfExp:");
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

  public void visit(IntExp exp, int level, boolean isAddr) {
    indent(level);
    System.out.println("IntExp: " + exp.value);
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

  public void visit(SimpleDec dec, int level, boolean isAddr) {
    indent(level);
    System.out.println("SimpleDec: " + dec.name);
    level++;
    if (dec.typ != null) {
      dec.typ.accept(this, level, isAddr);
    }
  }

  public void visit(ArrayDec dec, int level, boolean isAddr) {
    indent(level);
    System.out.println("ArrayDec: " + dec.name);
    level++;
    if (dec.typ != null) {
      dec.typ.accept(this, level, isAddr);
    }
    if (dec.size != null) {
      dec.size.accept(this, level, isAddr);
    }
  }


  public void visit(SimpleVar var, int level, boolean isAddr) {
    indent(level);
    System.out.println("SimpleVar: " + var.name);
  }

  public void visit(IndexVar var, int level, boolean isAddr) {
    indent(level);
    System.out.println("IndexVar: " + var.name);
    level++;
    if (var.index != null) {
      var.index.accept(this, level, isAddr);
    }
  }

  public void visit(VarDecList varDecList, int level, boolean isAddr) {
    while (varDecList != null) {
      if (varDecList.head != null) {
        varDecList.head.accept(this, level, isAddr);
      }
      varDecList = varDecList.tail;
    }
  }

  public void visit(VarExp exp, int level, boolean isAddr) {
    indent(level);
    System.out.println("VarExp: ");
    level++;
    if (exp.variable != null) {
      exp.variable.accept(this, level, isAddr);
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
