package absyn;
//NodeType: String name, Dec def, int level
public class NodeType {
  public String name;
  public Dec def;
  public int level;

  public NodeType( String name, Dec def, int level ) {

    this.name = name;
    this.def = def;
    this.level = level;
  }
//   idk if we need this prob not i think
//   public void accept( AbsynVisitor visitor, int level ) {
//     visitor.visit( this, level );
//   }
}
