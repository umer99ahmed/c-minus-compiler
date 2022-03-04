package absyn;

public class NameTy extends Absyn {
  public final static int INT = 0;
  public final static int VOID = 1;

  public Exp left;
  public int op;
  public Exp right;

  public NameTy( int row, int col, Exp left, int op, Exp right ) {
    this.row = row;
    this.col = col;
    this.left = left;
    this.op = op;
    this.right = right;
  }

  public void accept( AbsynVisitor visitor, int level ) {
    visitor.visit( this, level );
  }
}
