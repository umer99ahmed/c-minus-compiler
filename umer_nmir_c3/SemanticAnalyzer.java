import absyn.*;
import java.util.HashMap;
import java.util.ArrayList;

// global scope -> DecList
// block scope -> Compound

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

  // TYPE CHECKING: Checking if the function's return type matches that of the return statement
  private void typeCheckFunctionReturn(FunctionDec dec, int rType, ExpList body) {
    // This function iterates through the function's body, obtains the ReturnExp, and compares the
    // types
    boolean hasReturn = false;
    boolean hasIf = false;
    String returnExpError =
        "ERROR: Returned expression does not match function's return type at row ";

    while (body != null) {
      if(body.head instanceof IfExp){
        hasIf = true;
      }
      if (body.head instanceof ReturnExp) {
        hasReturn = true;
        VarDec rExp = ((ReturnExp) body.head).exp.dtype;
        if (rExp instanceof SimpleDec) {
          SimpleDec sDec = (SimpleDec) rExp;
          if (sDec.typ.type != rType) {
            symbolErrors.add(returnExpError + (sDec.row + 1) + ", column " + (sDec.col + 1) + ".");
          }
        } else if (rExp instanceof ArrayDec) {
          ArrayDec aDec = (ArrayDec) rExp;
          if (aDec.typ.type != rType) {
            symbolErrors.add(returnExpError + (aDec.row + 1) + ", column " + (aDec.col + 1) + ".");
          }
        } else if( rType != 1) {
          symbolErrors
              .add("ERROR: Invalid return type at row " + (((ReturnExp) body.head).exp.row + 1)
                  + ", column " + (((ReturnExp) body.head).exp.col + 1) + ".");
        }
      }
      body = body.tail;
    }
    // For the case in which there is no return statement in a function that has a return type of
    // int

    if (!hasReturn && rType == 0 && !hasIf) {
      symbolErrors
          .add("ERROR: Function with return type of int is missing a return statement at row "
              + (dec.row + 1) + ", column " + (dec.col + 1) + ".");
    }
  }

  private void typeCheckFunctionCall(CallExp call) {
    ExpList args = call.args;
    ArrayList<Exp> argList = new ArrayList<Exp>();
    ArrayList<VarDec> paramList = new ArrayList<VarDec>();
    while (args != null) {
      if (args.head != null) {
        argList.add(args.head);
      }
      args = args.tail;
    }
    if (table.containsKey(call.func)) {
      ArrayList<NodeType> vars = table.get(call.func);
      NodeType var = vars.get(vars.size() - 1);
      if (var.def instanceof FunctionDec) {
        VarDecList params = ((FunctionDec) var.def).params;
        while (params != null) {
          if (params.head != null) {
            paramList.add(params.head);
          }
          params = params.tail;
        }
        int numArgs = argList.size();
        int numParams = paramList.size();
        if (numArgs == numParams) {
          for (int i = 0; i < numArgs; i++) {
            int argType = -1; // 0 for int (simpledec or integer), 1 for arraydec
            int paramType = -1;
            if (argList.get(i).dtype instanceof SimpleDec) {
              if (((SimpleDec) argList.get(i).dtype).typ.type == 0) {
                argType = 0;
              }
            } else if (argList.get(i).dtype instanceof ArrayDec) {
              argType = 1;
            }
            if (paramList.get(i) instanceof SimpleDec) {
              paramType = 0;
            } else if (paramList.get(i) instanceof ArrayDec) {
              paramType = 1;
            }
            if (argType == -1 || argType != paramType) {
              symbolErrors.add("ERROR: Argument type does not match parameter type at row "
                  + (argList.get(i).row + 1) + ", column " + (argList.get(i).col + 1) + ".");
            }
          }
        } else {
          symbolErrors.add("ERROR: In function call, " + numParams + " argument(s) expected, but "
              + numArgs + " argument(s) provided at row " + (call.row + 1) + ", column "
              + (call.col + 1) + ".");
        }
      }
    }
  }


  public void visit(DecList decList, int level, boolean isAddr) {
    indent(level);
    System.out.println("Entering the global scope: ");
    //insert input
    FunctionDec inputDec = new FunctionDec(0,0,new NameTy(0, 0, NameTy.INT), new String("input"), new VarDecList(null, null),new CompoundExp(0, 0, null, null));
    NodeType inputNode = new NodeType(inputDec.func, inputDec, level);
    symTableInsert(inputNode);

    //insert output
    FunctionDec outputDec = new FunctionDec(0,0, new NameTy(0, 0, NameTy.VOID), new String("output"), new VarDecList(new SimpleDec(0, 0, new NameTy(0, 0, NameTy.INT), new String("")), null),new CompoundExp(0, 0, null, null));
    NodeType outputNode = new NodeType(outputDec.func, outputDec, level);
    symTableInsert(outputNode);

    while (decList != null) {
      if (decList.head != null) {
        decList.head.accept(this, level + 1, isAddr);
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

  public void visit(VarDecList varDecList, int level, boolean isAddr) {
    while (varDecList != null) {
      if (varDecList.head != null) {
        varDecList.head.accept(this, level, isAddr);
      }
      varDecList = varDecList.tail;
    }
  }

  public void visit(FunctionDec dec, int level, boolean isAddr) {
    indent(level);
    System.out.println("Entering the scope for function " + dec.func);

    NodeType node = new NodeType(dec.func, dec, level);
    symTableInsert(node);

    if (dec.result != null) {
      dec.result.accept(this, level + 1, isAddr);
    }
    if (dec.params != null) {
      dec.params.accept(this, level + 1, isAddr);
    }
    if (dec.body != null) {
      dec.body.accept(this, level + 1, true, isAddr);
    }


    typeCheckFunctionReturn(dec, dec.result.type, dec.body.exps);

    // print function var
    displayScopeVars(level);
    symTableDelete(level);


    indent(level);
    System.out.println("Leaving the scope for function " + dec.func);

  }

  public void visit(SimpleDec dec, int level, boolean isAddr) {

    if (dec.typ.type == 1) {
      symbolErrors.add("ERROR: Variable (" + dec.name
          + ") declared as VOID. Automatically changed to type INT at " + (dec.row + 1)
          + ", column " + (dec.col + 1) + ".");
      dec.typ.type = 0;
    }

    NodeType node = new NodeType(dec.name, dec, level);
    symTableInsert(node);
    // level++;
    if (dec.typ != null) {
      dec.typ.accept(this, level, isAddr);
    }
  }

  public void visit(ArrayDec dec, int level, boolean isAddr) {

    if (dec.typ.type == 1) {
      symbolErrors.add("ERROR: Variable (" + dec.name
          + ") declared as VOID[]. Automatically changed to type INT[] at " + (dec.row + 1)
          + ", column " + (dec.col + 1) + ".");
      dec.typ.type = 0;
    }

    NodeType node = new NodeType(dec.name, dec, level);
    symTableInsert(node);

    // level++;
    if (dec.typ != null) {
      dec.typ.accept(this, level, isAddr);
    }
    if (dec.size != null) {
      dec.size.accept(this, level, isAddr);
    }
  }

  public void visit(ExpList expList, int level, boolean isAddr) {
    while (expList != null) {
      if (expList.head != null) {

        expList.head.accept(this, level, isAddr);
      }
      expList = expList.tail;
    }
  }

  public void visit(CompoundExp exp, int level, boolean isAddr) {

    indent(level);
    System.out.println("Entering a new block: ");

    if (exp.decs != null) {
      exp.decs.accept(this, level + 1, isAddr);
    }
    if (exp.exps != null) {
      exp.exps.accept(this, level + 1, isAddr);
    }
    displayScopeVars(level);
    symTableDelete(level);
    indent(level);
    System.out.println("Leaving the new block: ");

  }

  public void visit(CompoundExp exp, int level, boolean isPreceded, boolean isAddr) {

    if (exp.decs != null) {
      exp.decs.accept(this, level, isAddr);
    }

    if (exp.exps != null) { 
      exp.exps.accept(this, level, isAddr);
    }

  }

  public void visit(AssignExp exp, int level, boolean isAddr) { 

    boolean isLeftArrayDec = false;
    boolean isRightArrayDec = false;
    int leftSideType = -1;
    int rightSideType = -1;

    if (exp.lhs != null) {
      exp.lhs.accept(this, level, isAddr);

      if (exp.lhs.dtype == null) {
        symbolErrors.add("ERROR: Invalid expression type to the left of assignment at row "
            + (exp.lhs.row + 1) + ", column " + (exp.lhs.col + 1) + ".");
      } else if (exp.lhs.dtype instanceof SimpleDec) {
        leftSideType = ((SimpleDec) exp.lhs.dtype).typ.type;
      } else if (exp.lhs.dtype instanceof ArrayDec) {
        isLeftArrayDec = true;
        leftSideType = ((ArrayDec) exp.lhs.dtype).typ.type;

      }
    }

    if (exp.rhs != null) {
      exp.rhs.accept(this, level, isAddr);
      if (exp.rhs.dtype == null) {
        symbolErrors.add("ERROR: Invalid expression type to the right of assignment at row "
            + (exp.rhs.row + 1) + ", column " + (exp.rhs.col + 1) + ".");
      } else if (exp.rhs.dtype instanceof SimpleDec) {
        rightSideType = ((SimpleDec) exp.rhs.dtype).typ.type;
      } else if (exp.rhs.dtype instanceof ArrayDec) {
        isRightArrayDec = true;
        rightSideType = ((ArrayDec) exp.rhs.dtype).typ.type;

      }
    }

    if (leftSideType != rightSideType || isLeftArrayDec != isRightArrayDec) {
      symbolErrors.add("ERROR: Expression types of assignment expression do not match at row "
          + (exp.row + 1) + ", column " + (exp.col + 1) + ".");
      exp.dtype = new SimpleDec(exp.row, exp.col, new NameTy(exp.row, exp.col, 0), "");

    } else {
      exp.dtype = isLeftArrayDec == false
          ? new SimpleDec(exp.row, exp.col, new NameTy(exp.row, exp.col, leftSideType), "")
          : new ArrayDec(exp.row, exp.col, ((ArrayDec) exp.lhs.dtype).typ, "",
              ((ArrayDec) exp.lhs.dtype).size);
    }

  }

  private void typeCheckTestCondition(Exp exp) {
    String errorMsg = "ERROR: Test condition must be of type integer at row ";
    VarDec dtype;

    if (exp instanceof IfExp) {
      dtype = ((IfExp) exp).test.dtype;
    } else {
      dtype = ((WhileExp) exp).test.dtype;
    }
    if (dtype instanceof SimpleDec) {
      if (((SimpleDec) dtype).typ.type != 0) {
        symbolErrors.add(errorMsg + (exp.row + 1) + ", column " + (exp.col + 1) + ".");
      }
    } else {
      symbolErrors.add(errorMsg + (exp.row + 1) + ", column " + (exp.col + 1) + ".");
    }
  }

  public void visit(IfExp exp, int level, boolean isAddr) {
    if (exp.test != null) {
      exp.test.accept(this, level, isAddr);
    }

    if (exp.thenpart != null) {
      exp.thenpart.accept(this, level, isAddr);
    }

    if (exp.elsepart != null) {
      exp.elsepart.accept(this, level, isAddr);
    }

    typeCheckTestCondition(exp);

  }


  public void visit(IntExp exp, int level, boolean isAddr) {

    exp.dtype = new SimpleDec(exp.row, exp.col, new NameTy(exp.row, exp.col, NameTy.INT), "");
    // indent( level );
  }

  public void visit(NameTy typ, int level, boolean isAddr) {

  }

  public void visit(NilExp exp, int level, boolean isAddr) {
  }

  public void visit(OpExp exp, int level, boolean isAddr) {

    StringBuilder op = new StringBuilder();
    switch (exp.op) {
      case OpExp.PLUS:
        op.append(" + ");
        break;
      case OpExp.MINUS:
        op.append(" - ");
        break;
      case OpExp.TIMES:
        op.append(" * ");
        break;
      case OpExp.OVER:
        op.append(" / ");
        break;
      case OpExp.LTEQ:
        op.append(" <= ");
        break;
      case OpExp.GTEQ:
        op.append(" >= ");
        break;
      case OpExp.EQ:
        op.append(" == ");
        break;
      case OpExp.NOTEQ:
        op.append(" != ");
        break;
      case OpExp.LT:
        op.append(" < ");
        break;
      case OpExp.GT:
        op.append(" > ");
        break;
      default:
        System.out.println("Unrecognized operator at line " + exp.row + " and column " + exp.col);
    }

    int leftSideType = -1;
    int rightSideType = -1;

    if (exp.left != null) {
      exp.left.accept(this, level, isAddr);

      if (exp.left.dtype != null && exp.left.dtype instanceof SimpleDec) {
        leftSideType = ((SimpleDec) exp.left.dtype).typ.type;
        // symbolErrors.add("ERROR: Invalid expression type to the left of
        // operator("+op.toString()+") at row " + (exp.lhs.row + 1) + ", column " + (exp.lhs.col +
        // 1) + ".");
      }
    }

    if (exp.right != null) {
      exp.right.accept(this, level, isAddr);
      if (exp.right.dtype != null && exp.right.dtype instanceof SimpleDec) {
        rightSideType = ((SimpleDec) exp.right.dtype).typ.type;
      }
    }

    if (leftSideType != 0) {
      symbolErrors.add(
          "ERROR: Expression must evaluate to type 'int' to the left of operator(" + op.toString()
              + ") at row " + (exp.left.row + 1) + ", column " + (exp.left.col + 1) + ".");
    }
    if (rightSideType != 0) {
      symbolErrors.add(
          "ERROR: Expression must evaluate to type 'int' to the right of operator(" + op.toString()
              + ") at row " + (exp.left.row + 1) + ", column " + (exp.left.col + 1) + ".");
    }

    exp.dtype = new SimpleDec(exp.row, exp.col, new NameTy(exp.row, exp.col, 0), "");

  }

  public void visit(ReturnExp exp, int level, boolean isAddr) {
    if (exp.exp != null) {
      exp.exp.accept(this, level, isAddr);
    }
  }


  public void visit(CallExp exp, int level, boolean isAddr) {

    if (!table.containsKey(exp.func)) {
      symbolErrors.add("ERROR: Undefined symbol (" + exp.func + "()) at row " + (exp.row + 1)
          + ", column " + (exp.col + 1) + ".");
    } else {
      ArrayList<NodeType> vars = table.get(exp.func);
      NodeType var = vars.get(vars.size() - 1);
      exp.relatedDef = (FunctionDec)var.def;
      // get type of var in table and copy into VarExp.dtype
      if (var.def instanceof FunctionDec) {// SimpleDec
        exp.dtype = new SimpleDec(exp.row, exp.col, ((FunctionDec) var.def).result, "");
      }
    }

    if (exp.args != null) {
      exp.args.accept(this, level, isAddr);
    }

    typeCheckFunctionCall(exp);
  }

  public void visit(SimpleVar var, int level, boolean isAddr) {

    if (!table.containsKey(var.name)) {
      symbolErrors.add("ERROR: Undefined symbol (" + var.name + ") at row " + (var.row + 1)
          + ", column " + (var.col + 1) + ".");
      return;
    } else {
      ArrayList<NodeType> vars = table.get(var.name);
      NodeType dec = vars.get(vars.size() - 1);
      var.relatedDef = (SimpleDec)dec.def;
    }
  }

  public void visit(IndexVar var, int level, boolean isAddr) {

    if (!table.containsKey(var.name)) {
      symbolErrors.add("ERROR: Undefined symbol (" + var.name + "[]) at row " + (var.row + 1)
          + ", column " + (var.col + 1) + ".");
    } else {
      ArrayList<NodeType> vars = table.get(var.name);
      NodeType dec = vars.get(vars.size() - 1);
      var.relatedDef = (ArrayDec)dec.def;
    }


    if (var.index != null) {
      var.index.accept(this, level, isAddr);
      if (var.index.dtype == null) {
        symbolErrors.add("ERROR: Invalid index provided for array variable (" + var.name
            + ") at row " + (var.row + 1) + ", column " + (var.col + 1) + ".");

      } else if ((var.index.dtype instanceof SimpleDec
          && ((SimpleDec) var.index.dtype).typ.type != 0)
          || (var.index.dtype instanceof ArrayDec)) { 
        symbolErrors.add("ERROR: Invalid index type (expected 'int') for the array variable ("
            + var.name + ") at row " + (var.row + 1) + ", column " + (var.col + 1) + ".");
      } 
    }
  }

  public void visit(VarExp exp, int level, boolean isAddr) {

    if (exp.variable != null) {
      exp.variable.accept(this, level, isAddr);

      // if variable is Simplevar && declared
      if (exp.variable instanceof SimpleVar && table.containsKey(((SimpleVar) exp.variable).name)) {
        ArrayList<NodeType> vars = table.get(((SimpleVar) exp.variable).name);
        NodeType var = vars.get(vars.size() - 1);
        if (var.def instanceof SimpleDec) {
          exp.dtype = new SimpleDec(exp.row, exp.col, ((SimpleDec) var.def).typ, "");
        } else if (var.def instanceof ArrayDec) {
          exp.dtype = new ArrayDec(exp.row, exp.col, ((ArrayDec) var.def).typ, "",
              ((ArrayDec) var.def).size);
        }
        // else if (var.def instanceof FunctionDec) {
        // exp.dtype = new SimpleDec(exp.row, exp.col, ((FunctionDec) var.def).result, "");
        // }
      } else if (exp.variable instanceof IndexVar
          && table.containsKey(((IndexVar) exp.variable).name)) {


        ArrayList<NodeType> vars = table.get(((IndexVar) exp.variable).name);
        NodeType var = vars.get(vars.size() - 1);

        // if (var.def instanceof ArrayDec) {
        // exp.dtype = new ArrayDec(exp.row, exp.col, ((ArrayDec) var.def).typ, "",
        // ((ArrayDec) var.def).size);
        // }
        if (var.def instanceof ArrayDec) {
          exp.dtype = new SimpleDec(exp.row, exp.col, ((ArrayDec) var.def).typ, "");
        }
      }
    }
  }

  public void visit(WhileExp exp, int level, boolean isAddr) {

    if (exp.test != null) {
      exp.test.accept(this, level, isAddr);
    }
    if (exp.body != null) {
      exp.body.accept(this, level, isAddr);
    }

    typeCheckTestCondition(exp);
  }
}
