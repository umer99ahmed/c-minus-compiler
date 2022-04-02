package absyn;

public class NameTy extends Absyn {
  public final static int INT = 0;
  public final static int VOID = 1;

  public int type;

  public NameTy( int row, int col, int type ) {
    this.row = row;
    this.col = col;
    this.type = type;
  }

  public void accept( AbsynVisitor visitor, int level, boolean isAddr ) {
    visitor.visit( this, level, isAddr );
  }
}
