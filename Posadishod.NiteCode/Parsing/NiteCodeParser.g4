parser grammar NiteCodeParser;

@header {
}

options {
    tokenVocab = NiteCodeLexer;
    superClass = NiteCodeParserBase;
}

mainStatement
    : (NITECODE_USE (SEMI)?)?
      usingStatements?
      EOF
    ;

anyStatement
    : emptyStatement
    ;

emptyStatement: SEMI;

usingStatements
    : usingStatement*
    ;
    
usingStatement
    : USING Integer_Literal SEMI
    ;
