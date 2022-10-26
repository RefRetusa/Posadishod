parser grammar NiteCodeParser;

@header {
}

options {
    tokenVocab = NiteCodeLexer;
    superClass = NiteCodeParserBase;
}

compilation_unit
    : header_unit? EOF
    ;

header_unit
    :
      using_unit*
      define_unit*
    ;

using_unit
    : USING STATIC namespace_or_type_name SEMI
    | USING namespace_or_type_name SEMI
    ;
define_unit
    : DEFINE TYPE IDENTIFIER OP_ASSIGN namespace_or_type_name SEMI
    ;

namespace_or_type_name 
	: (IDENTIFIER type_argument_list?) (DOT IDENTIFIER type_argument_list?)*
	;

bool_type
    : TYPE_BOOL
    ;

integral_type 
	: TYPE_U8 | TYPE_U16 | TYPE_U32 | TYPE_U64
    | TYPE_I8 | TYPE_I16 | TYPE_I32 | TYPE_I64
    ;

floating_point_type 
	: TYPE_F32 | TYPE_F64 | TYPE_F128
	;

memory_type
    : TYPE_VOID | TYPE_SIZE | TYPE_PTR
    ;

class_type 
	: namespace_or_type_name
	| TYPE_OBJECT
	| TYPE_STRING
	;

any_type
    : bool_type
    | integral_type
    | floating_point_type
    | memory_type
    | class_type
    ;

type_argument_list 
	: LEFT_GENERIC any_type ( COMMA any_type)* RIGHT_GENERIC
	;