/*
 * Created by: Umer Ahmed and Numan Mir File Name: CM.java To Build: After the scanner cm.flex, and
 * the parser, tiny.cup, have been created. javac Main.java
 * 
 * To Run: java -classpath /usr/share/java/cup.jar:. Main gcd.tiny
 * 
 * where gcd.tiny is an test input file for the tiny language.
 */

import java.io.*;
import absyn.*;

class CM {
  public static boolean SHOW_TREE = false;
  public static boolean SHOW_SYM = false;

  static public void main(String argv[]) {
    /* Start the parser */
    try {

      int filenameIndex = 0;
      if (argv.length == 1) {
        System.err.println(
            "usage: CM -[FLAG] [FILEPATH]\n[FLAG]\ta : perform syntactic analysis and output an abstract syntax tree (.abs)\n\ts : perform type checking and output symbol tables (.sym)\n\t(default output syntax error)\n\n");
      } else if (argv.length == 2) {

        if (argv[0].equals("-a")) { // to-do: add -c for C3 here and below
          SHOW_TREE = true;
          filenameIndex = 1;
        } else if (argv[0].equals("-s")) {
          SHOW_SYM = true;
          filenameIndex = 1;
        } else {
          System.err.println(
              "usage: CM -[FLAG] [FILEPATH]\n[FLAG]\ta : perform syntactic analysis and output an abstract syntax tree (.abs)\n\ts : perform type checking and output symbol tables (.sym)\n\t(default output syntax error)\n\n");
        }
      }


      parser p = new parser(new Lexer(new FileReader(argv[filenameIndex])));
      StringBuilder filename =
          new StringBuilder(argv[filenameIndex].substring(0, argv[filenameIndex].length() - 3));
      // System.out.println(filename.toString());

      Absyn result = (Absyn) (p.parse().value);
      if (SHOW_TREE && result != null) {
        filename.append(".abs");
        PrintStream fileOutAbs = new PrintStream(filename.toString());
        System.setOut(fileOutAbs);

        System.out.println("The abstract syntax tree is:");
        ShowTreeVisitor visitorAbs = new ShowTreeVisitor();
        result.accept(visitorAbs, 0, false);
      }
      if (SHOW_SYM && result != null && ((DecList) result).hasSyntacticErr == false) {
        filename.append(".sym");
        PrintStream fileOutSym = new PrintStream(filename.toString());
        System.setOut(fileOutSym);

        System.out.println("The semantic analysis annotated tree:");
        SemanticAnalyzer visitorSym = new SemanticAnalyzer();
        result.accept(visitorSym, 0, false);

        System.err.println("code gerneration");
        CodeGenerator cmcode = new CodeGenerator();
        cmcode.visit(result);
      }
    } catch (Exception e) {
      /* do cleanup here -- possibly rethrow e */
      System.err.println(
          "usage: CM -[FLAG] [FILEPATH]\n[FLAG]\ta : perform syntactic analysis and output an abstract syntax tree (.abs)\n\ts : perform type checking and output symbol tables (.sym)\n\t(default output syntax error)\n");
      e.printStackTrace();
    }
  }
}


