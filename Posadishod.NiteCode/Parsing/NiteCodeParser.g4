parser grammar NiteCodeParser;

@header {
}

options {
    tokenVocab = NiteCodeLexer;
    superClass = NiteCodeParserBase;
}

mainStatement
    : (BYTE_ORDER_MARK)?

      anyStatement*

      EOF
    ;

anyStatement
    : usingStatement
    | emptyStatement
    ;

emptyStatement
    : SEMICOLON
    ;

usingStatement
    : USING LITERAL SEMICOLON
    ;