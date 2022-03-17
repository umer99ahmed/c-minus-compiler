/*
  Created by: Umer Ahmed and Numan Mir
  File Name: CM.java
  To Build: 
  After the scanner cm.flex, and the parser, tiny.cup, have been created.
    javac Main.java
  
  To Run: 
    java -classpath /usr/share/java/cup.jar:. Main gcd.tiny

  where gcd.tiny is an test input file for the tiny language.
*/
   
import java.io.*;
import absyn.*;
   
class CM {
  public static boolean SHOW_TREE = false;
  static public void main(String argv[]) {    
    /* Start the parser */
    try {
      
      int filenameIndex = 0;
      if(argv.length == 2){
        if(argv[0].equals("-a") || argv[0].equals("-s")) { //to-do: add -c for C3 here and below
          SHOW_TREE = true;
          filenameIndex = 1;
        } else if (argv[1].equals("-a") || argv[1].equals("-s")) {
          SHOW_TREE = true;
          filenameIndex = 0;
        } else {
          System.out.println("Invalid arguments.");
          //error, invalid flag provided
        }
      }

      
      // PrintStream fileOut = new PrintStream(argv[filenameIndex].substring(argv[filenameIndex].length()-3,argv[filenameIndex].length() ) + ".abs");
      // System.setOut(fileOut);
      parser p = new parser(new Lexer(new FileReader(argv[filenameIndex])));

   
      Absyn result = (Absyn)(p.parse().value);      
      if (SHOW_TREE && result != null) {
        //  System.out.println("The abstract syntax tree is:");
        //  ShowTreeVisitor visitor = new ShowTreeVisitor();
        //  result.accept(visitor, 0);
        
         System.out.println("The semantic analysis annotated tree:");
         SemanticAnalyzer visitor = new SemanticAnalyzer();
         result.accept(visitor, 0);

      }
    } catch (Exception e) {
      /* do cleanup here -- possibly rethrow e */
      e.printStackTrace();
    }
  }
}


