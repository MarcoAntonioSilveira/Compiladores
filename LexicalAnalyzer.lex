import java_cup.runtime.*;

%%

%cup
%public
%class LexicalAnalyzer


Letter 					= [A-Za-z]
Digit 					= ([0] | [2-9])
Identifier			= {Letter} ({Letter} | {Digit})*
UnsignedInt 		= {Digit}+
Sign 						= \+ | \- | _
ScaleFactor 		= [E] {Sign} {UnsignedInt}
UnsignedReal	 	= {UnsignedInt} (_ | \. | {Digit}*(_ | {ScaleFactor}))
IntegerConstant = {UnsignedInt}
RealConstant 		= {UnsignedReal}
CharConstant 		= [^\r\n]



%%

<YYINITIAL> {

	"+" 			{ return new Symbol(Sym.ADDOP); }
	"-" 			{ return new Symbol(Sym.ADDOP); }
	"or" 			{ return new Symbol(Sym.ADDOP); }

	"*" 			{ return new Symbol(Sym.MULOP); }
	"/" 			{ return new Symbol(Sym.MULOP); }
	"div" 		{ return new Symbol(Sym.MULOP); }
	"mod" 		{ return new Symbol(Sym.MULOP); }
	"and" 		{ return new Symbol(Sym.MULOP); }

	"=" 			{ return new Symbol(Sym.RELOP); }
	"<" 			{ return new Symbol(Sym.RELOP); }
	">" 			{ return new Symbol(Sym.RELOP); }
	"<=" 			{ return new Symbol(Sym.RELOP); }
	">=" 			{ return new Symbol(Sym.RELOP); }
	"!=" 			{ return new Symbol(Sym.RELOP); }
	"NOT" 		{ return new Symbol(Sym.RELOP); }

	","				{ return new Symbol(Sym.COMMA); }
	";"				{ return new Symbol(Sym.SEMI); }
	":"				{ return new Symbol(Sym.COLON); }
	"("				{ return new Symbol(Sym.LEFT_PAR); }
	")"				{ return new Symbol(Sym.RIGHT_PAR); }
	"-"				{ return new Symbol(Sym.MINUS); }

	"if"			{ return new Symbol(Sym.IF); }
	"then"		{ return new Symbol(Sym.THEN); }
	"else"    { return new Symbol(Sym.ELSE); }
	"do"			{ return new Symbol(Sym.DO); }
	"while"		{ return new Symbol(Sym.WHILE); }
	"until"		{ return new Symbol(Sym.UNTIL); }
	"end"			{ return new Symbol(Sym.END); }

	"read"		{ return new Symbol(Sym.READ); }
	"write"		{ return new Symbol(Sym.WRITE); }
	"true"		{ return new Symbol(Sym.TRUE); }
	"false"		{ return new Symbol(Sym.FALSE); }
	"write"		{ return new Symbol(Sym.WRITE); }
	"assign"	{ return new Symbol(Sym.ASSIGN); }

	"boolean" { return new Symbol(Sym.BOOLEAN); }
	"real" 		{ return new Symbol(Sym.REAL); }
	"integer" { return new Symbol(Sym.INTEGER); }

	{Identifier} 			{ return new Symbol(Sym.IDENTIFIER); }
	{IntegerConstant}	{ return new Symbol(Sym.INTEGER_CONST); }
	{CharConstant}		{ return new Symbol(Sym.CHAR_CONST); }
	{RealConstant}		{ return new Symnol(Sym.REAL_CONST); }



}
<<EOF>> 	{ return new Symbol(Sym.EOF); }

[^] { throw new Error("Illegal character: "+yytext()+" at line "+(yyline+1)+", column "+(yycolumn+1) ); }
