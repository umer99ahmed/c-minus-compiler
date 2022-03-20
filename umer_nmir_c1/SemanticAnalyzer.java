import absyn.*;
import java.util.HashMap;
import java.util.ArrayList;

//global scope -> DecList
// block scope -> Compound 
// 

public class SemanticAnalyzer implements AbsynVisitor {

  HashMap<String, ArrayList<NodeType>> table; //NodeType: String name, Dec def, int level
  final static int SPACES = 4;
  
  public SemanticAnalyzer(){
    table = new HashMap<String, ArrayList<NodeType>>();
  }

  private void indent( int level ) {
    for( int i = 0; i < level * SPACES; i++ ) System.out.print( " " );
  }


  private void symTableInsert( NodeType node ){
    // indent( node.level );

    // System.out.println("inserting "+ node.name  );
    table.putIfAbsent( node.name,  new ArrayList<>());
    table.get(node.name).add(node);
     // System.out.println("[");
    // for(int i = 0; i < table.get(node.name).size(); i++){
    //   System.out.println(table.get(node.name).get(i).name + " "+ table.get(node.name).get(i).level);
    // }
    // System.out.println("]");
      
    if (node.def instanceof SimpleDec) {
      // indent( node.level );
      // System.out.println("simpledec detected "+ ((SimpleDec)node.def).name);
    }
    //insert <string (dec.name), NodeType including dec.name, dec, level>
  }
  
  private void symTableLookUp ( ) {

  }

  private void symTableDelete (int level) {
    for (String key : table.keySet()) {
      ArrayList<NodeType> vars = table.get(key);
      if(vars.size() == 0){ continue; }
      int topVarIndex = vars.size() - 1;
      NodeType var = vars.get(topVarIndex); //get the last variable in the key's arraylist 
      if (var.level == level + 1) { // if the top most variable in the list is the current level
        vars.remove(topVarIndex);
      }      
    }
  }

  private void displayScopeVars(int level) {
    //display annotated global variables before leaving
    for ( String key : table.keySet() ) {
   
      ArrayList<NodeType> vars = table.get(key);
      if(vars.size() == 0){ continue; }
      NodeType var = vars.get( vars.size() - 1 ); //get the last variable in the key's arraylist 

      // if that var belongs to this scope 
      if (var.level == level + 1 ){

        if (var.def instanceof SimpleDec) {        //SimpleDec
          String type = ((SimpleDec)var.def).typ.type == 0 ? "int" : "void";
          indent( var.level );
          System.out.println( var.name+":"+" "+ type );
        } else if (var.def instanceof FunctionDec) {        //FunctionDec
          String returnType = ((FunctionDec)var.def).result.type == 0 ? "int" : "void";
          
          // building a string of params if instance of functionDec
          StringBuilder paramsStr = new StringBuilder();
          VarDecList params = ((FunctionDec)var.def).params;
          while( params != null ) {
            if ( params.head != null ) {
                if ( params.head instanceof SimpleDec ) {
                  String paramType = ((SimpleDec)params.head).typ.type == 0 ? "int" : "void";
                  paramsStr.append(params.tail == null ? paramType : paramType + ", ");
              } else if ( params.head instanceof ArrayDec ) {
                  String paramType = ((ArrayDec)params.head).typ.type == 0 ? "int" : "void";
                  paramsStr.append(params.tail == null ? paramType + "[]" : paramType + "[], ");
              }
            } 
            params = params.tail;
          }
          indent( var.level );
          System.out.println( var.name + ":" + " ("+paramsStr+")" + " -> " + returnType );
        } else if (var.def instanceof ArrayDec) {        //ArrayDec
          String type = ((ArrayDec)var.def).typ.type == 0 ? "int" : "void";
          String size = ((ArrayDec)var.def).size != null ? ""+((ArrayDec)var.def).size.value : "";
          indent( var.level );
          System.out.println( var.name+ ":" + " " + type + "[" + size + "]" );
        }
      }
    }
  }

  public void visit( DecList decList, int level ){
    indent( level );
    System.out.println( "Entering the global scope: ");

    while( decList != null ) {
      if(decList.head != null){
        decList.head.accept( this, level+1 );
      }
      decList = decList.tail;
    } 

    displayScopeVars(level);
    symTableDelete(level);
    
    System.out.println( "Leaving the global scope");

  }

  public void visit( VarDecList varDecList, int level ){
    while( varDecList != null ) {
      if(varDecList.head != null){
        varDecList.head.accept( this, level );
      }
      varDecList = varDecList.tail;
    } 
  }

  public void visit( FunctionDec dec, int level ){
    indent( level );
    System.out.println("Entering the scope for function " + dec.func);
    // System.out.println( "FunctionDec: " + dec.func );
    // level++;
    NodeType node = new NodeType(dec.func, dec, level );
    symTableInsert( node );

    if(dec.result != null){
      dec.result.accept( this, level+1 );
    }
    if(dec.params != null){
      dec.params.accept( this, level+1 );
    }
    if(dec.body != null){
      dec.body.accept( this, level+1, true );
    }

    //print function var
    displayScopeVars(level);
    symTableDelete(level);
    indent(level);
    System.out.println("Leaving the scope for function " + dec.func);
  }

  public void visit( SimpleDec dec, int level ){
    // indent( level );
    // System.out.println( "SimpleDec: "+ dec.name);
    NodeType node = new NodeType(dec.name, dec, level );
    symTableInsert( node );
    //level++;
    if(dec.typ != null){
      dec.typ.accept( this, level+1 );
    }
  }

  public void visit( ArrayDec dec, int level ){
    // indent( level );
    // System.out.println( "ArrayDec: "+ dec.name);
    //level++;
    NodeType node = new NodeType(dec.name, dec, level );
    symTableInsert( node );
    
    if(dec.typ != null){
          dec.typ.accept( this, level+1 );
    }
    if(dec.size != null){
      dec.size.accept( this, level+1 );
    }
  }

 public void visit( ExpList expList, int level ){
    while( expList != null ) {
      if(expList.head != null){
        expList.head.accept( this, level );
      }
      expList = expList.tail;
    } 
  }

    public void visit( CompoundExp exp, int level ){
      // System.out.println( "test: ");
      indent( level );
      System.out.println( "Entering a new block: ");

      if (exp.decs != null) {
        exp.decs.accept( this, level+1 );
      }
      if(exp.exps!= null){ 
        exp.exps.accept( this, level+1 );
      }
      displayScopeVars(level);
      symTableDelete(level);
      indent(level);
      System.out.println( "Leaving the new block: ");

  }
  public void visit( CompoundExp exp, int level, boolean isPreceded ){
      //     indent( level );
      // System.out.println( "isPreceded");

    //level++;
    if (exp.decs != null) {
      exp.decs.accept( this, level );
    }
        
    if(exp.exps!= null){ //??
      exp.exps.accept( this, level );
    }

  }

  public void visit( AssignExp exp, int level ) {
    // indent( level );
    // System.out.println( "AssignExp:" );
    // level++;
    // if(exp.lhs != null){
    //   exp.lhs.accept( this, level );
    // }
    // if(exp.rhs != null){
    //   exp.rhs.accept( this, level );
    // }
  }
  
  public void visit( CallExp exp, int level ){
    // indent( level );
    // System.out.println( "CallExp: " + exp.func);
    // level++;
    // if(exp.args != null){
    //   exp.args.accept( this, level );
    // }
    
  }


  public void visit( IfExp exp, int level ){
    // indent( level );
    // System.out.println( "IfExp:" );
    // level++;

    // if( exp.test != null){
    //   exp.test.accept( this, level );
    // }

    // if( exp.thenpart != null){
    //   exp.thenpart.accept( this, level );
    // }

    // if( exp.elsepart != null){
    //   exp.elsepart.accept( this, level );
    // }
  }

  public void visit( IntExp exp, int level ){
    // indent( level );
    // System.out.println( "IntExp: " + exp.value ); 
  }

  public void visit( NameTy typ, int level ){
    //wall
    // indent( level );
    // if(typ.type == 0){
    //   System.out.println( "NameTy: int" ); 
    // }
    // if(typ.type == 1){
    //   System.out.println( "NameTy: void" ); 
    // }
  }

  public void visit( NilExp exp, int level ){
    // indent( level );
    // System.out.println( "NilExp: "); 
  }

  public void visit( OpExp exp, int level ) {
    // indent( level );
    // System.out.print( "OpExp:" ); 
    // switch( exp.op ) {
    //   case OpExp.PLUS:
    //     System.out.println( " + " );
    //     break;
    //   case OpExp.MINUS:
    //     System.out.println( " - " );
    //     break;
    //   case OpExp.TIMES:
    //     System.out.println( " * " );
    //     break;
    //   case OpExp.OVER:
    //     System.out.println( " / " );
    //     break;      
    //   case OpExp.LTEQ:
    //     System.out.println( " <= " );
    //     break;
    //   case OpExp.GTEQ:
    //     System.out.println( " >= " );
    //     break;
    //   case OpExp.EQ:
    //     System.out.println( " == " );
    //     break;
    //   case OpExp.NOTEQ:
    //     System.out.println( " != " );
    //     break;
    //   case OpExp.LT:
    //     System.out.println( " < " );
    //     break;
    //   case OpExp.GT:
    //     System.out.println( " > " );
    //     break;
    //   default:
    //     System.out.println( "Unrecognized operator at line " + exp.row + " and column " + exp.col);
    // }
    // level++;
    // if( exp.left != null){
    //   exp.left.accept( this, level );
    // }
    // if( exp.right != null){
    //   exp.right.accept( this, level );
    // }
  }

  public void visit( ReturnExp exp, int level ){
    // indent( level );
    // System.out.println( "ReturnExp: ");
    // level++;
    // if(exp.exp != null){
    //   exp.exp.accept( this, level );
    // }
  }


  public void visit( SimpleVar var, int level ){
    // indent( level );
    // System.out.println( "SimpleVar: "+ var.name);
  }

  public void visit( IndexVar var, int level ){
    // indent( level );
    // System.out.println( "IndexVar: "+ var.name);
    // level++;
    // if(var.index != null){
    //   var.index.accept( this, level );
    // }
  }



  public void visit( VarExp exp, int level ) {
    // indent( level );
    // System.out.println( "VarExp: ");
    // level++;
    // if(exp.variable != null){
    //   exp.variable.accept(this, level);
    // }
  }

  public void visit( WhileExp exp, int level ){
    // indent( level );
    // System.out.println( "WhileExp:" );
    // level++;
    // if(exp.test != null){
    //   exp.test.accept( this, level ); 
    // }    
    // if(exp.body != null){
    //   exp.body.accept( this, level );
    // }
  }


}
