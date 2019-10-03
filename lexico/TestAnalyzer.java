package comp1;

import java.io.IOException;
import java.io.StringReader;

public class TestAnalyzer {
	public static void main(String[] args) throws IOException{
	    String test = "0L";
	    LexicalAnalyzer instance = new LexicalAnalyzer(new StringReader(test));
	    instance.yylex();
 	}
}