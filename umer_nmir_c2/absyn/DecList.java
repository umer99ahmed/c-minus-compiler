package absyn;

public class DecList extends Absyn {
  public Dec head;
  public DecList tail;
  public boolean hasSyntacticErr;

  public DecList( Dec head, DecList tail ) {
    this.head = head;
    this.tail = tail;
    this.hasSyntacticErr = false;
  }

  public void accept( AbsynVisitor visitor, int level ) {
    visitor.visit( this, level );
  }
}
