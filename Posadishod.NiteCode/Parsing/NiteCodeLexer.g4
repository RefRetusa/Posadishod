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

// Other
SINGLELINE_COMMENT: '//' InputCharacter* -> channel(COMMENTS);
MULTILINE_COMMENT: '/*' .*? '*/' InputCharacter* -> channel(COMMENTS);
WHITESPACES: (Whitespace | NewLine)+ -> channel(HIDDEN);
fragment NewLine
	: '\r\n' | '\r' | '\n'
	| '\u0085' // <Next Line CHARACTER (U+0085)>'
	| '\u2028' //'<Line Separator CHARACTER (U+2028)>'
	| '\u2029' //'<Paragraph Separator CHARACTER (U+2029)>'
	;
fragment Whitespace
	: UnicodeClassZS
    | '\u0009' //'<Horizontal Tab Character (U+0009)>'
	| '\u000B' //'<Vertical Tab Character (U+000B)>'
	| '\u000C' //'<Form Feed Character (U+000C)>'
	;
fragment InputCharacter:       ~[\r\n\u0085\u2028\u2029];

// Identifier
IDENTIFIER: Identifier;
fragment Identifier
	: 'a' .. 'z'
	| 'A' .. 'Z'
	;

// Unicode classes
fragment UnicodeClassZS
	: '\u0020' // SPACE
	| '\u00A0' // NO_BREAK SPACE
	| '\u1680' // OGHAM SPACE MARK
	| '\u180E' // MONGOLIAN VOWEL SEPARATOR
	| '\u2000' // EN QUAD
	| '\u2001' // EM QUAD
	| '\u2002' // EN SPACE
	| '\u2003' // EM SPACE
	| '\u2004' // THREE_PER_EM SPACE
	| '\u2005' // FOUR_PER_EM SPACE
	| '\u2006' // SIX_PER_EM SPACE
	| '\u2008' // PUNCTUATION SPACE
	| '\u2009' // THIN SPACE
	| '\u200A' // HAIR SPACE
	| '\u202F' // NARROW NO_BREAK SPACE
	| '\u3000' // IDEOGRAPHIC SPACE
	| '\u205F' // MEDIUM MATHEMATICAL SPACE
	;

// Numerics
fragment Integer_Literal
    : Dec_Digit_Literal
    | Hex_Digit_Literal
    | Oct_Digit_Literal
    | Bin_Digit_Literal
    ;

fragment Dec_Digit_Literal: Raw_Dec_Digit Dec_Digit* Integer_Suffix?;
fragment Dec_Digit: '_'* Raw_Dec_Digit;
fragment Raw_Dec_Digit: '0'..'9';

fragment Hex_Digit_Literal: ('0x' | '0X') Hex_Digit* Integer_Suffix?;
fragment Hex_Digit: '_'* Raw_Hex_Digit;
fragment Raw_Hex_Digit: '0'..'9' | 'A'..'F' | 'a'..'f';

fragment Oct_Digit_Literal: ('0c' | '0C') Oct_Digit* Integer_Suffix?;
fragment Oct_Digit: '_'* Raw_Oct_Digit;
fragment Raw_Oct_Digit: '0'..'7';

fragment Bin_Digit_Literal: ('0b' | '0B') Bin_Digit* Integer_Suffix?;
fragment Bin_Digit: '_'* Raw_Bin_Digit;
fragment Raw_Bin_Digit: '0' | '1';

fragment Integer_Suffix
    : 'i8' | 'I8' | 'u8' | 'U8'
    | 'i16' | 'I16' | 'u16' | 'U16'
    | 'i32' | 'I32' | 'u32' | 'U32'
    | 'i64' | 'I64' | 'u64' | 'U64'
    ;

// Keywords
CONST: 'const';
NEW: 'new';
STATIC: 'static';
READONLY: 'readonly';
USING: 'using';

PUBLIC: 'public';
PRIVATE: 'private';
PROTECTED: 'protected';

TYPE: 'type';
STRUCT: 'struct';
CLASS: 'class';
METHOD: 'method';
OPERATOR: 'operator';
EXPLICIT: 'explicit';
IMPLICIT: 'implicit';
DISCARD: '_';

// Control flow
IF: 'if';
ELSE: 'else';
SWITCH: 'switch';
CASE: 'case';
DEFAULT: 'default';
BREAK: 'break';
DO: 'do';
FOR: 'for';
CONTINUE: 'continue';
RETURN: 'return';

// Basic types
I8: [iI]'8';
I16: [iI]'16';
I32: [iI]'32';
I64: [iI]'64';

U8: [uU]'8';
U16: [uU]'16';
U32: [uU]'32';
U64: [uU]'64';

F32: [fF]'32' | 'float' | 'single';
F64: [fF]'64' | 'double';
F128: [fF]'128' | 'triple' | 'decimal';

STRING: 'string';


// Operators

OP_INCREMENT: '++';
OP_DECREMENT: '--';
OP_LEFT: '<<';
OP_RIGHT: '>>';
OP_MORE_OR_EQ: '>=';
OP_LESS_OR_EQ: '<=';
OP_ASSIGN_NEGATE: '!=';
OP_ASSIGN_PLUS: '+=';
OP_ASSIGN_MINUS: '-=';
OP_ASSIGN_MULTIPLY: '*=';
OP_ASSIGN_DIVIDE: '/=';
OP_ASSIGN_MODULE: '%=';
OP_ASSIGN_LEFT: '<<=';
OP_ASSIGN_RIGHT: '>>=';
OP_ASSIGN_BIT_AND: '&=';
OP_ASSIGN_BIT_XOR: '^=';
OP_ASSIGN_BIT_OR: '|=';
OP_LOGIC_OR: '||';
OP_LOGIC_XOR: '^^';
OP_LOGIC_AND: '&&';
OP_LOGIC_EQUAL: '==';

OP_PLUS: '+';
OP_MINUS: '-';
OP_DOT: '.';
OP_GET: '::';
OP_NEGATE: '!';
OP_MULTIPLY: '*';
OP_DIVIDE: '/';
OP_MODULE: '%';
OP_LESS: '<';
OP_MORE: '>';
OP_BIT_NEGATE: '~';
OP_BIT_OR: '|';
OP_BIT_XOR: '^';
OP_BIT_AND: '&';
OP_ASSIGN: '=';
OP_NULL: 'null';

ATTRIBUTE_APPLY: '@';
NITECODE_USE: '<NiteCode>';

L_CIR: '(';
L_FIG: '{';
L_SQR: '[';
R_CIR: ')';
R_FIG: '}';
R_SQR: ']';
COMMA: ',';
RANGE: '..';
SEMI: ';';


PP: '#' -> pushMode(PP_Mode);

mode PP_Mode;
IFDEF: 'ifdef';
IFNDEF: 'ifndef';
