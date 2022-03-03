package absyn;

public class ReturnExp extends Exp {
  public VarDecList decs;
  public ExpList exps;

  public ReturnExp( int row, int col, VarDecList decs, ExpList exps ) {
    this.row = row;
    this.col = col;
    this.decs = decs;
    this.exps = exps;
  }

  public void accept( AbsynVisitor visitor, int level ) {
    visitor.visit( this, level );
  }
}
