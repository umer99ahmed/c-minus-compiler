package absyn;

abstract public class VarDec extends Dec {
    int offset; // offset within related stackframe
    int nestLevel; // either a 0 for global scope or a 1 for local scope
}
