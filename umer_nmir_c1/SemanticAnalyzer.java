import absyn.*;
import java.util.HashMap;
import java.util.ArrayList;

// global scope -> DecList
// block scope -> Compound
//

public class SemanticAnalyzer implements AbsynVisitor {

  HashMap<String, ArrayList<NodeType>> table; // NodeType: String name, Dec def, int level
  ArrayList<String> symbolErrors;
  final static int SPACES = 4;

  public SemanticAnalyzer() {
    table = new HashMap<String, ArrayList<NodeType>>();
    symbolErrors = new ArrayList<String>();
  }

  private void indent(int level) {
    for (int i = 0; i < level * SPACES; i++)
      System.out.print(" ");
  }


  private void symTableInsert(NodeType node) {
    table.putIfAbsent(node.name, new ArrayList<>());
    // table.get(node.name).add(node);

    ArrayList<NodeType> vars = table.get(node.name);
    if (vars.size() > 0) {
      if (vars.get(vars.size() - 1).level == node.level) {
        StringBuilder error = new StringBuilder("ERROR: Redefined symbol (" + node.name + ") ");
        // System.err.print("ERROR: Redefined symbol (" +node.name+ ") ");
        if (node.def instanceof SimpleDec) {
          error.append(" at row " + (((SimpleDec) node.def).row + 1) + ", column "
              + (((SimpleDec) node.def).col + 1) + ".");
        } else if (node.def instanceof FunctionDec) {
          error.append(" at row " + (((FunctionDec) node.def).row + 1) + ", column "
              + (((FunctionDec) node.def).col + 1) + ".");
        } else if (node.def instanceof ArrayDec) {
          error.append(" at row " + (((ArrayDec) node.def).row + 1) + ", column "
              + (((ArrayDec) node.def).col + 1) + ".");
        }
        symbolErrors.add(error.toString());
        return;
      }
    }
    vars.add(node);
  }

  private void symTableLookUp() {

  }

  private void symTableDelete(int level) {
    for (String key : table.keySet()) {
      ArrayList<NodeType> vars = table.get(key);
      if (vars.size() == 0) {
        continue;
      }
      int topVarIndex = vars.size() - 1;
      NodeType var = vars.get(topVarIndex); // get the last variable in the key's arraylist
      if (var.level == level + 1) { // if the top most variable in the list is the current level
        vars.remove(topVarIndex);
      }
      // if (vars.size() == 0) { //remove the key if the array is empty
      // table.remove(key);
      // }
    }

    table.entrySet().removeIf(entry -> (entry.getValue().size() == 0));


  }

  private void displayScopeVars(int level) {
    // display annotated global variables before leaving
    for (String key : table.keySet()) {

      ArrayList<NodeType> vars = table.get(key);
      if (vars.size() == 0) {
        continue;
      }
      NodeType var = vars.get(vars.size() - 1); // get the last variable in the key's arraylist

      // if that var belongs to this scope
      if (var.level == level + 1) {

        if (var.def instanceof SimpleDec) { // SimpleDec
          String type = ((SimpleDec) var.def).typ.type == 0 ? "int" : "void";
          indent(var.level);
          System.out.println(var.name + ":" + " " + type);
        } else if (var.def instanceof FunctionDec) { // FunctionDec
          String returnType = ((FunctionDec) var.def).result.type == 0 ? "int" : "void";

          // building a string of params if instance of functionDec
          StringBuilder paramsStr = new StringBuilder();
          VarDecList params = ((FunctionDec) var.def).params;
          if (params.head == null) {
            paramsStr.append("void");
          }
          while (params != null) {
            if (params.head != null) {
              if (params.head instanceof SimpleDec) {
                String paramType = ((SimpleDec) params.head).typ.type == 0 ? "int" : "void";
                paramsStr.append(params.tail == null ? paramType : paramType + ", ");
              } else if (params.head instanceof ArrayDec) {
                String paramType = ((ArrayDec) params.head).typ.type == 0 ? "int" : "void";
                paramsStr.append(params.tail == null ? paramType + "[]" : paramType + "[], ");
              }
            }
            params = params.tail;
          }
          indent(var.level);
          System.out.println(var.name + ":" + " (" + paramsStr + ")" + " -> " + returnType);
        } else if (var.def instanceof ArrayDec) { // ArrayDec
          String type = ((ArrayDec) var.def).typ.type == 0 ? "int" : "void";
          String size =
              ((ArrayDec) var.def).size != null ? "" + ((ArrayDec) var.def).size.value : "";
          indent(var.level);
          System.out.println(var.name + ":" + " " + type + "[" + size + "]");
        }
      }
    }
  }

  public void visit(DecList decList, int level) {
    indent(level);
    System.out.println("Entering the global scope: ");

    while (decList != null) {
      if (decList.head != null) {
        decList.head.accept(this, level + 1);
      }
      decList = decList.tail;
    }

    displayScopeVars(level);
    symTableDelete(level);

    System.out.println("Leaving the global scope\n");

    symbolErrors.forEach(error -> {
      System.err.println(error);
    });

  }

  public void visit(VarDecList varDecList, int level) {
    while (varDecList != null) {
      if (varDecList.head != null) {
        varDecList.head.accept(this, level);
      }
      varDecList = varDecList.tail;
    }
  }

  public void visit(FunctionDec dec, int level) {
    indent(level);
    System.out.println("Entering the scope for function " + dec.func);
    // System.out.println( "FunctionDec: " + dec.func );
    // level++;
    NodeType node = new NodeType(dec.func, dec, level);
    symTableInsert(node);

    if (dec.result != null) {
      dec.result.accept(this, level + 1);
    }
    if (dec.params != null) {
      dec.params.accept(this, level + 1);
    }
    if (dec.body != null) {
      dec.body.accept(this, level + 1, true);
    }
    // print function var
    displayScopeVars(level);
    symTableDelete(level);
    indent(level);
    System.out.println("Leaving the scope for function " + dec.func);
  }

  public void visit(SimpleDec dec, int level) {
    // indent( level );
    // System.out.println( "SimpleDec: "+ dec.name);
    NodeType node = new NodeType(dec.name, dec, level);
    symTableInsert(node);
    // level++;
    if (dec.typ != null) {
      dec.typ.accept(this, level);
    }
  }

  public void visit(ArrayDec dec, int level) {
    // indent( level );
    // System.out.println( "ArrayDec: "+ dec.name);
    NodeType node = new NodeType(dec.name, dec, level);
    symTableInsert(node);

    // level++;
    if (dec.typ != null) {
      dec.typ.accept(this, level);
    }
    if (dec.size != null) {
      dec.size.accept(this, level);
    }
  }

  public void visit(ExpList expList, int level) {
    while (expList != null) {
      if (expList.head != null) {
        expList.head.accept(this, level);
      }
      expList = expList.tail;
    }
  }

  public void visit(CompoundExp exp, int level) {
    // System.out.println( "test: ");
    indent(level);
    System.out.println("Entering a new block: ");

    if (exp.decs != null) {
      exp.decs.accept(this, level + 1);
    }
    if (exp.exps != null) {
      exp.exps.accept(this, level + 1);
    }
    displayScopeVars(level);
    symTableDelete(level);
    indent(level);
    System.out.println("Leaving the new block: ");

  }

  public void visit(CompoundExp exp, int level, boolean isPreceded) {
    // indent( level );
    // System.out.println( "isPreceded");

    // level++;
    if (exp.decs != null) {
      exp.decs.accept(this, level);
    }

    if (exp.exps != null) { // ??
      exp.exps.accept(this, level);
    }

  }

  public void visit(AssignExp exp, int level) { // TC
    // indent( level );
    // System.out.println( "AssignExp:" );
    // level++;
    if (exp.lhs != null) {
      exp.lhs.accept(this, level);
    }
    if (exp.rhs != null) {
      exp.rhs.accept(this, level);
    }
  }


  public void visit(IfExp exp, int level) {
    // indent( level );
    // System.out.println( "IfExp:" );
    // level++;
    if (exp.test != null) {
      exp.test.accept(this, level);
    }

    if (exp.thenpart != null) {
      exp.thenpart.accept(this, level);
    }

    if (exp.elsepart != null) {
      exp.elsepart.accept(this, level);
    }
  }

  public void visit(IntExp exp, int level) {
    exp.dtype = new SimpleDec(exp.row, exp.col, new NameTy(exp.row, exp.col, NameTy.INT), "");
    // indent( level );
    // System.out.println( "IntExp: " + exp.value );
  }

  public void visit(NameTy typ, int level) {

    // indent( level );
    // if(typ.type == 0){
    // System.out.println( "NameTy: int" );
    // }
    // if(typ.type == 1){
    // System.out.println( "NameTy: void" );
    // }
  }

  public void visit(NilExp exp, int level) {
    // indent( level );
    // System.out.println( "NilExp: ");
  }

  public void visit(OpExp exp, int level) {
    // indent( level );
    // System.out.print( "OpExp:" );
    // switch( exp.op ) {
    // case OpExp.PLUS:
    // System.out.println( " + " );
    // break;
    // case OpExp.MINUS:
    // System.out.println( " - " );
    // break;
    // case OpExp.TIMES:
    // System.out.println( " * " );
    // break;
    // case OpExp.OVER:
    // System.out.println( " / " );
    // break;
    // case OpExp.LTEQ:
    // System.out.println( " <= " );
    // break;
    // case OpExp.GTEQ:
    // System.out.println( " >= " );
    // break;
    // case OpExp.EQ:
    // System.out.println( " == " );
    // break;
    // case OpExp.NOTEQ:
    // System.out.println( " != " );
    // break;
    // case OpExp.LT:
    // System.out.println( " < " );
    // break;
    // case OpExp.GT:
    // System.out.println( " > " );
    // break;
    // default:
    // System.out.println( "Unrecognized operator at line " + exp.row + " and column " + exp.col);
    // }
    // level++;
    if (exp.left != null) {
      exp.left.accept(this, level);
    }
    if (exp.right != null) {
      exp.right.accept(this, level);
    }
  }

  public void visit(ReturnExp exp, int level) {
    // indent( level );
    // System.out.println( "ReturnExp: ");
    // level++;
    if (exp.exp != null) {
      exp.exp.accept(this, level);
    }
  }

  public void visit(CallExp exp, int level) {// TC
    // indent( level );
    // System.out.println( "CallExp: " + exp.func);
    // level++;
    if (!table.containsKey(exp.func)) {
      // indent( level );
      symbolErrors.add("ERROR: Undefined symbol (" + exp.func + "()) at row " + (exp.row + 1)
          + ", column " + (exp.col + 1) + ".");
      // System.err.println("ERROR: Undefined symbol (" + exp.func + "()) at row " + (exp.row + 1) +
      // ", column " + (exp.col + 1) + ".");
    } else{
        ArrayList<NodeType> vars = table.get(exp.func);
        NodeType var = vars.get(vars.size() - 1);
        //get type of var in table and copy into VarExp.dtype
        if (var.def instanceof FunctionDec) {// SimpleDec
          exp.dtype = new SimpleDec(exp.row, exp.col, ((FunctionDec)var.def).result, "");
        } 
    }
      

    if (exp.args != null) {
      exp.args.accept(this, level);
    }

  }

  public void visit(SimpleVar var, int level) {
    // System.out.println("SIMPLEVAR"+ var.name);
    // indent( level );
    // System.out.println( "SimpleVar: "+ var.name);
    if (!table.containsKey(var.name)) {
      symbolErrors.add("ERROR: Undefined symbol (" + var.name + ") at row " + (var.row + 1)
          + ", column " + (var.col + 1) + ".");
      return;
    }
    // var.dtype = new SimpleDec(exp.row, exp.col, new NameTy(exp.row, exp.col, NameTy.INT), "" );

  }

  public void visit(IndexVar var, int level) {
    // indent( level );
    // System.out.println( "IndexVar: "+ var.name);
    // level++;

    if (!table.containsKey(var.name)) {
      symbolErrors.add("ERROR: Undefined symbol (" + var.name + "[]) at row " + (var.row + 1)
          + ", column " + (var.col + 1) + ".");
    }


    if (var.index != null) {
      var.index.accept(this, level);

      if(var.index.dtype == null){
          indent(level);
          System.err.println("ERROR:  Invalid index provided for array variable (" + var.name + ") at row " + (var.row + 1)
          + ", column " + (var.col + 1) + ".");

      } else if( (var.index.dtype instanceof SimpleDec && ((SimpleDec) var.index.dtype).typ.type != 0)  || (var.index.dtype instanceof ArrayDec && ((ArrayDec)var.index.dtype).typ.type != 0) ){
          indent(level);
          System.err.println("ERROR: Invalid index type (expected 'int') for the array variable (" + var.name + ") at row " + (var.row + 1)
          + ", column " + (var.col + 1) + ".");
      } else {
        // indent(level);
        // System.err.println("TYPE CHECK SUCCESS");
      }
    }
  }

  public void visit(VarExp exp, int level) { // num
    // indent( level );
    // System.out.println( "VarExp: ");
    // level++;
    if (exp.variable != null) {
      exp.variable.accept(this, level);

      //if variable is Simplevar && declared
      if (exp.variable instanceof SimpleVar && table.containsKey(((SimpleVar) exp.variable).name)) {
        ArrayList<NodeType> vars = table.get(((SimpleVar) exp.variable).name);
        NodeType var = vars.get(vars.size() - 1);

        if (var.def instanceof SimpleDec) {
          exp.dtype = new SimpleDec(exp.row, exp.col, ((SimpleDec) var.def).typ, "");
        } 
      }else if(exp.variable instanceof IndexVar && table.containsKey(((IndexVar)exp.variable).name)){
        ArrayList<NodeType> vars = table.get(((IndexVar) exp.variable).name);
        NodeType var = vars.get(vars.size() - 1);

        if (var.def instanceof ArrayDec) {
          exp.dtype = new ArrayDec(exp.row, exp.col, ((ArrayDec) var.def).typ, "", ((ArrayDec) var.def).size);
        } 
      }
    }
  }

  public void visit(WhileExp exp, int level) {
    // indent( level );
    // System.out.println( "WhileExp:" );
    // level++;
    if (exp.test != null) {
      exp.test.accept(this, level);
    }
    if (exp.body != null) {
      exp.body.accept(this, level);
    }
  }
}
