import absyn.*;

public class ShowTreeVisitor implements AbsynVisitor {

  final static int SPACES = 4;

  private void indent( int level ) {
    for( int i = 0; i < level * SPACES; i++ ) System.out.print( " " );
  }

  public void visit( AssignExp exp, int level ) {
    indent( level );
    System.out.println( "AssignExp:" );
    level++;
    if(exp.lhs != null){
      exp.lhs.accept( this, level );
    }
    if(exp.rhs != null){
      exp.rhs.accept( this, level );
    }
  }
  
  public void visit( CallExp exp, int level ){
    indent( level );
    System.out.println( "CallExp: " + exp.func);
    level++;
    if(exp.args != null){
      exp.args.accept( this, level );
    }
    
  }

  public void visit( CompoundExp exp, int level ){
    indent( level );
    System.out.println( "CompoundExp: ");
    level++;
    if (exp.decs != null) {
      exp.decs.accept( this, level );
    }
        
    if(exp.exps!= null){
      exp.exps.accept( this, level );
    }

  }

  public void visit( DecList decList, int level ){
    while( decList != null ) {
      if(decList.head != null){
        decList.head.accept( this, level );
      }
      decList = decList.tail;
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

  public void visit( FunctionDec dec, int level ){
    indent( level );
    System.out.println( "FunctionDec: " + dec.func );
    level++;
    
    if(dec.result != null){
      dec.result.accept( this, level );
    }
    if(dec.params != null){
      dec.params.accept( this, level );
    }
    if(dec.body != null){
      dec.body.accept( this, level );
    }
  }

  public void visit( IfExp exp, int level ){
    indent( level );
    System.out.println( "IfExp:" );
    level++;

    if( exp.test != null){
      exp.test.accept( this, level );
    }

    if( exp.thenpart != null){
      exp.thenpart.accept( this, level );
    }

    if( exp.elsepart != null){
      exp.elsepart.accept( this, level );
    }
  }

  public void visit( IntExp exp, int level ){
    indent( level );
    System.out.println( "IntExp: " + exp.value ); 
  }

  public void visit( NameTy typ, int level ){
    indent( level );
    if(typ.type == 0){
      System.out.println( "NameTy: int" ); 
    }
    if(typ.type == 1){
      System.out.println( "NameTy: void" ); 
    }
  }

  public void visit( NilExp exp, int level ){
    indent( level );
    System.out.println( "NilExp: "); 
  }

  public void visit( OpExp exp, int level ) {
    indent( level );
    System.out.print( "OpExp:" ); 
    switch( exp.op ) {
      case OpExp.PLUS:
        System.out.println( " + " );
        break;
      case OpExp.MINUS:
        System.out.println( " - " );
        break;
      case OpExp.TIMES:
        System.out.println( " * " );
        break;
      case OpExp.OVER:
        System.out.println( " / " );
        break;      
      case OpExp.LTEQ:
        System.out.println( " <= " );
        break;
      case OpExp.GTEQ:
        System.out.println( " >= " );
        break;
      case OpExp.EQ:
        System.out.println( " == " );
        break;
      case OpExp.NOTEQ:
        System.out.println( " != " );
        break;
      case OpExp.LT:
        System.out.println( " < " );
        break;
      case OpExp.GT:
        System.out.println( " > " );
        break;
      default:
        System.out.println( "Unrecognized operator at line " + exp.row + " and column " + exp.col);
    }
    level++;
    if( exp.left != null){
      exp.left.accept( this, level );
    }
    if( exp.right != null){
      exp.right.accept( this, level );
    }
  }

  public void visit( ReturnExp exp, int level ){
    indent( level );
    System.out.println( "ReturnExp: ");
    level++;
    if(exp.exp != null){
      exp.exp.accept( this, level );
    }
  }

  public void visit( SimpleDec dec, int level ){
    indent( level );
    System.out.println( "SimpleDec: "+ dec.name);
    level++;
    if(dec.typ != null){
      dec.typ.accept( this, level );
    }
  }

  public void visit( ArrayDec dec, int level ){
    indent( level );
    System.out.println( "ArrayDec: "+ dec.name);
    level++;
    if(dec.typ != null){
          dec.typ.accept( this, level );
    }
    if(dec.size != null){
      dec.size.accept( this, level );
    }
  }


  public void visit( SimpleVar var, int level ){
    indent( level );
    System.out.println( "SimpleVar: "+ var.name);
  }

  public void visit( IndexVar var, int level ){
    indent( level );
    System.out.println( "IndexVar: "+ var.name);
    level++;
    if(var.index != null){
      var.index.accept( this, level );
    }
  }

  public void visit( VarDecList varDecList, int level ){
    while( varDecList != null ) {
      if(varDecList.head != null){
        varDecList.head.accept( this, level );
      }
      varDecList = varDecList.tail;
    } 
  }

  public void visit( VarExp exp, int level ) {
    indent( level );
    System.out.println( "VarExp: ");
    level++;
    if(exp.variable != null){
      exp.variable.accept(this, level);
    }
  }

  public void visit( WhileExp exp, int level ){
    indent( level );
    System.out.println( "WhileExp:" );
    level++;
    if(exp.test != null){
      exp.test.accept( this, level ); 
    }    
    if(exp.body != null){
      exp.body.accept( this, level );
    }
  }


}
