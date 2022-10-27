lexer grammar NiteCodeLexer;

@header{
}

channels { COMMENTS }

options {
    superClass = NiteCodeLexerBase;
}

SINGLE_LINE_COMMENT: '//' InputCharacter* -> channel(COMMENTS);
DELIMITED_COMMENT: '/*' .*? '*/' -> channel(COMMENTS);

USING: 'using';
NAMEOF: 'nameof';
ARGS: 'args';
STATIC: 'static';
DEFINE: 'define';
TYPE: 'type';
CONST: 'const';
GLOBAL: 'global';
NAMESPACE: 'namespace';

PUBLIC: 'public';
PRIVATE: 'private';
PROTECTED: 'protected';

ENUM: 'enum';
STRUCT: 'struct';
CLASS: 'class';

SEMI: ';';
COLON: ':';

TYPE_OBJECT: 'object';
TYPE_I8:  'i8';
TYPE_I16: 'i16';
TYPE_I32: 'i32';
TYPE_I64: 'i64';
TYPE_U8:  'u8';
TYPE_U16: 'u16';
TYPE_U32: 'u32';
TYPE_U64: 'u64';
TYPE_F32: 'f32' | 'float';
TYPE_F64: 'f64' | 'double';
TYPE_F128: 'f128' | 'decimal';
TYPE_BOOL: 'bool';
TYPE_STRING: 'string';
TYPE_VOID: 'void';
TYPE_PTR: 'ptr';
TYPE_SIZE: 'size';

OP_ASSIGN: '=';
OP_PLUS: '+';
OP_MINUS: '-';

LEFT_GENERIC: '<';
RIGHT_GENERIC: '>';
COMMA: ',';
DOT: '.';

// Rules
IDENTIFIER: Identifier;
WHITESPACES: (Whitespace | NewLine)+ -> channel(HIDDEN);
NUMBER
	: (OP_MINUS | OP_PLUS)* '0x' HexDigit+
	| (OP_MINUS | OP_PLUS)* '0ct' OctDigit+
	| (OP_MINUS | OP_PLUS)* '0b' BinDigit+
	| (OP_MINUS | OP_PLUS)* DecDigit+
	;

fragment InputCharacter: ~[\r\n\u0085\u2028\u2029];

fragment Identifier
	: IdentifierStartCharacter IdentifierPartCharacter*
	;

fragment IdentifierStartCharacter
    : LetterCharacter
    | '_'
    ;

fragment IdentifierPartCharacter
    : LetterCharacter
    | DecDigit
    | '_'
    ;

fragment LetterCharacter
    : 'a' .. 'z'
    | 'A' .. 'Z'
	| '\u00C0' .. '\u00FF'
    ;

fragment OctDigit
    : '0' .. '7'
    ;
fragment HexDigit
    : '0' .. '9'
    | 'a' .. 'f'
    | 'A' .. 'F'
    ;
fragment DecDigit
    : '0' .. '9'
    ;
fragment BinDigit
    : '0' .. '1'
    ;

fragment NewLine
	: '\r\n' | '\r' | '\n'
	| '\u0085' // <Next Line CHARACTER (U+0085)>'
	| '\u2028' //'<Line Separator CHARACTER (U+2028)>'
	| '\u2029' //'<Paragraph Separator CHARACTER (U+2029)>'
	;

fragment Whitespace
	: UnicodeClassZS //'<Any Character With Unicode Class Zs>'
	| '\u0009' //'<Horizontal Tab Character (U+0009)>'
	| '\u000B' //'<Vertical Tab Character (U+000B)>'
	| '\u000C' //'<Form Feed Character (U+000C)>'
	;

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