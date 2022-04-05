package absyn;

abstract public class VarDec extends Dec {
    public int offset; // offset within related stackframe
    public int nestLevel; // either a 0 for global scope or a 1 for local scope
}
