import java_cup.runtime.*;

%%
%line
%column
%cup
%public
%class LexicalAnalyzer

%{
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    
    /* Cria um new java_cup.runtime.Symbol com informacoes sobre
       o token corrente, o token possui um valor*/
       
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
    
    public String current_lexeme(){
        int l = yyline+1;
        int c = yycolumn+1;
        return " (line: "+l+" , column: "+c+" , lexeme: '"+yytext()+"')";
    }
    
    public int current_line() {
        return yyline+1;
    }
%}

Letter 					= [A-Za-z]
Digit 					= ([0-9])
Identifier			    = {Letter} ({Letter} | {Digit})*
UnsignedInt 		    = {Digit}+
Sign 					= \+ | \- | _
ScaleFactor 		    = [E] {Sign} {UnsignedInt}
UnsignedReal	 	    = {UnsignedInt} (_ | \. | {Digit}*(_ | {ScaleFactor}))
IntegerConstant         = {UnsignedInt}
RealConstant 		    = {UnsignedReal}
CharConstant 		    = [^\r\n]


%%

<YYINITIAL> {

    " "             {}
    "\n"            {}
    "\t"            {}
    "program"       { return symbol(Sym.PROGRAM); }

	"+" 			{ return symbol(Sym.ADDOP); }
	"-" 			{ return symbol(Sym.ADDOP); }
	"or" 			{ return symbol(Sym.ADDOP); }

	"*" 			{ return symbol(Sym.MULOP); }
	"/" 			{ return symbol(Sym.MULOP); }
	"div" 		    { return symbol(Sym.MULOP); }
	"mod" 		    { return symbol(Sym.MULOP); }
	"and" 		    { return symbol(Sym.MULOP); }

	"=" 			{ return symbol(Sym.RELOP); }
	"<" 			{ return symbol(Sym.RELOP); }
	">" 			{ return symbol(Sym.RELOP); }
	"<=" 			{ return symbol(Sym.RELOP); }
	">=" 			{ return symbol(Sym.RELOP); }
	"!=" 			{ return symbol(Sym.RELOP); }
	"not" 		    { return symbol(Sym.NOT); }

	","				{ return symbol(Sym.COMMA); }
	";"				{ return symbol(Sym.SEMI); }
	":"				{ return symbol(Sym.COLON); }
	"("				{ return symbol(Sym.LEFT_PAR); }
	")"				{ return symbol(Sym.RIGHT_PAR); }
	"-"				{ return symbol(Sym.MINUS); }

    "begin"         { return symbol(Sym.BEGIN); }
    "end"           { return symbol(Sym.END); }
	"if"			{ return symbol(Sym.IF); }
	"then"		    { return symbol(Sym.THEN); }
	"else"          { return symbol(Sym.ELSE); }
	"do"			{ return symbol(Sym.DO); }
	"while"		    { return symbol(Sym.WHILE); }
	"until"		    { return symbol(Sym.UNTIL); }
	"end"			{ return symbol(Sym.END); }

	"read"		    { return symbol(Sym.READ); }
	"write"		    { return symbol(Sym.WRITE); }
	"true"		    { return symbol(Sym.TRUE); }
	"false"		    { return symbol(Sym.FALSE); }
	"write"		    { return symbol(Sym.WRITE); }
	":="	        { return symbol(Sym.ASSIGN); }

	"boolean"       { return symbol(Sym.BOOLEAN); }
	"real" 		    { return symbol(Sym.REAL); }
	"integer"       { return symbol(Sym.INTEGER); }
	"char"          { return symbol(Sym.CHAR); }

	{Identifier} 		{ return symbol(Sym.IDENTIFIER); }
	{IntegerConstant}	{ return symbol(Sym.INTEGER_CONST); }
	{CharConstant}		{ return symbol(Sym.CHAR_CONST); }
	{RealConstant}		{ return symbol(Sym.REAL_CONST); }

}
<<EOF>> 	{ return symbol(Sym.EOF); }

[^] { throw new Error("Illegal character: "+yytext()+" at line "+(yyline+1)+", column "+(yycolumn+1) ); }
