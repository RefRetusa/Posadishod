lexer grammar NiteCodeLexer;

@header {
}

options {
    superClass = NiteCodeLexerBase;
}

channels {
    COMMENTS,
    PREPROC
}

BYTE_ORDER_MARK: '\u00EF\u00BB\u00BF';
WHIITESPACES: (Whitespace | NewLine)+ -> channel(HIDDEN);

LITERAL: LiteralBegin*;

NULLPTR: 'nullptr';
SEMICOLON: ';';
COLON: ':';
USING: 'using';

fragment Whitespace
    : ' '
    | '\t'
    ;

fragment NewLine
    : '\r\n' | '\r' | '\n'
    | '\u0085'
	| '\u2028'
	| '\u2029'
    ;
fragment LiteralBegin
    : 'a' .. 'z'
    | 'A' .. 'Z'
    | '_'
    ;