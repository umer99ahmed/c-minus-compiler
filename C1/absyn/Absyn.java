package absyn;

abstract public class Absyn {
  public int row, col;

  //NameTy defined here?

  // leave this out until we work on displaying the tree?
  abstract public void accept( AbsynVisitor visitor, int level );
}
