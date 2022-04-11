package absyn;

public class DecList extends Absyn {
  public Dec head;
  public DecList tail;
  public boolean hasSyntacticErr;
  public boolean hasSemanticErr;

  public DecList(Dec head, DecList tail) {
    this.head = head;
    this.tail = tail;
    this.hasSyntacticErr = false;
    this.hasSemanticErr = false;
  }

  public void accept(AbsynVisitor visitor, int level, boolean isAddr) {
    visitor.visit(this, level, isAddr);
  }
}
