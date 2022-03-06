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
    exp.lhs.accept( this, level );
    exp.rhs.accept( this, level );
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
    exp.decs.accept( this, level );
    exp.exps.accept( this, level );

  }

  public void visit( DecList dec, int level ){
    
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
    
  }

  public void visit( IfExp exp, int level ){
    indent( level );
    System.out.println( "IfExp:" );
    level++;
    // indent( level );
    // System.out.println( "test:" );

    exp.test.accept( this, level );
    // indent( level );
    // System.out.println( "then:" );

    exp.thenpart.accept( this, level );
    // if (exp.elsepart != null )
    //^ should we leave this in and make IfExp take null for elsepart?
    // indent( level );
    // System.out.println( "else:" );

    exp.elsepart.accept( this, level );
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
    exp.left.accept( this, level );
    exp.right.accept( this, level );
  }

  public void visit( ReturnExp exp, int level ){
    indent( level );
    System.out.println( "ReturnExp: ");
    level++;
    exp.exp.accept( this, level );
  }

  public void visit( SimpleDec dec, int level ){
    indent( level );
    System.out.println( "SimpleDec: "+ dec.name);
    level++;
    dec.typ.accept( this, level );
  }

  public void visit( ArrayDec dec, int level ){
    indent( level );
    System.out.println( "ArrayDec: "+ dec.name);
    level++;
    dec.typ.accept( this, level );
    dec.size.accept( this, level );
  }


  public void visit( SimpleVar var, int level ){
    indent( level );
    System.out.println( "SimpleVar: "+ var.name);
  }

  public void visit( IndexVar var, int level ){
    indent( level );
    System.out.println( "IndexVar: "+ var.name);
    level++;
    var.index.accept( this, level );
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
    exp.variable.accept(this, level);
  }

  public void visit( WhileExp exp, int level ){
    indent( level );
    System.out.println( "WhileExp:" );
    level++;
    exp.test.accept( this, level ); 
    exp.body.accept( this, level );
  }

  




  // public void visit( IfExp exp, int level ) {
  //   indent( level );
  //   System.out.println( "IfExp:" );
  //   level++;
  //   exp.test.accept( this, level );
  //   exp.thenpart.accept( this, level );
  //   if (exp.elsepart != null )
  //      exp.elsepart.accept( this, level );
  // }




  // public void visit( ReadExp exp, int level ) {
  //   indent( level );
  //   System.out.println( "ReadExp:" );
  //   exp.input.accept( this, ++level );
  // }



  // public void visit( VarExp exp, int level ) {
  //   indent( level );
  //   System.out.println( "VarExp: " + exp.name );
  // }

  // public void visit( WriteExp exp, int level ) {
  //   indent( level );
  //   System.out.println( "WriteExp:" );
  //   exp.output.accept( this, ++level );
  // }

}
