parser grammar NiteCodeParser;

@header {
}

options {
    tokenVocab = NiteCodeLexer;
    superClass = NiteCodeParserBase;
}

compilation_unit
    :
      header_unit? content_unit* EOF
    |
      EOF
    ;

header_unit
    :
      (
        using_unit* define_unit*
        |
        define_unit* using_unit*
      )
      namespace_unit?
    ;

content_unit 
    : method_declr
    | type_declr
    ;

method_declr
    : access_modifer_unit STATIC? any_type IDENTIFIER LEFT_BRACKET args_list RIGHT_BRACKET SEMI // Empty code
    | access_modifer_unit STATIC? any_type IDENTIFIER LEFT_BRACKET args_list RIGHT_BRACKET LEFT_CURLY code_statement* RIGHT_CURLY // Code inside
    | access_modifer_part STATIC? any_type IDENTIFIER LEFT_BRACKET args_list RIGHT_BRACKET LAMBDA code_expr SEMI
    ;
code_statement
    : any_type IDENTIFIER OP_ASSIGN code_expr SEMI // type varname = expr;
    | IDENTIFIER OP_ASSIGN code_expr SEMI // varname = expr;
    | LEFT_CURLY code_statement* RIGHT_CURLY // { code }
    | IF LEFT_BRACKET code_expr RIGHT_BRACKET code_statement // if (expr) code
    | ELSE code_statement // else code
    | method_invoke SEMI
    | GOTO IDENTIFIER SEMI // goto ACT4;
    | RETURN code_expr SEMI // return expr;
    ;

method_invoke
    : method_name LEFT_BRACKET args_invoke_list RIGHT_BRACKET #methodInvoke // Class.act<i32>(nullptr, varname2, 0);
    ;

code_expr
    : code_expr binary_operator code_expr // expr BIN_OP expr
    | LEFT_BRACKET code_expr RIGHT_BRACKET // (varname or expr)
    | IDENTIFIER // varname
    | DEFAULT (LEFT_GENERIC any_type RIGHT_GENERIC)? // default or default<i32>
    | NUMBER // 0x1F1
    | bool_value // false
    | string_value // "string"
    | OP_NEW any_type LEFT_BRACKET args_invoke_list RIGHT_BRACKET
    | unary_operator code_expr // --x or ~x
    | code_expr math_unary_operator // x++
    | method_invoke // act() + x
    ;

type_declr
    : struct_declr
    ;

struct_declr
    : access_modifer_unit
      (GENERIC LEFT_GENERIC generic_args_list RIGHT_GENERIC)?
      (SIZEOF (LEFT_GENERIC fixed_size_type RIGHT_GENERIC | LEFT_BRACKET (NUMBER|IDENTIFIER) RIGHT_BRACKET))?
      STRUCT IDENTIFIER
      where_unit*
      LEFT_CURLY RIGHT_CURLY
    ;

binary_operator
    : OP_MINUS
    | OP_PLUS
    | OP_DIV
    | OP_MUL
    | OP_MOD
    | OP_POW
    | OP_LEFT_SHIFT
    | OP_RIGHT_SHIFT
    | OP_BIT_AND
    | OP_BIT_OR
    | OP_BIT_XOR
    | OP_BOOL_AND
    | OP_BOOL_OR
    | OP_BOOL_XOR
    ;

math_unary_operator
    : OP_U_MINUS
    | OP_U_PLUS
    ;

unary_operator
    : math_unary_operator
    | OP_U_BIT_NEGATE
    | OP_U_NEGATE
    ;

where_unit
    : WHERE IDENTIFIER COLON any_type (COMMA any_type)* SEMI
    ;

access_modifer_unit
    : access_modifer_part access_modifer_part? // public or private or private protected
    ;

access_modifer_part
    : PUBLIC
    | PRIVATE
    | PROTECTED
    ;

args_list
    : (any_type IDENTIFIER (COMMA any_type IDENTIFIER)* )?
    ;

generic_args_list
    : generic_arg_unit (COMMA generic_arg_unit)*
    ;

generic_arg_unit
    : CONST const_type IDENTIFIER // <const i32 id> (only constable types)
    | generic_name
    ;

generic_name
    : THIS_G
    | IDENTIFIER
    ;

args_invoke_list
    : ((IDENTIFIER COLON)? code_expr  (COMMA (IDENTIFIER COLON)? code_expr)*  )?
    ;

namespace_unit
    : NAMESPACE namespace_or_type_name SEMI
    ;

using_unit
    : USING STATIC namespace_or_type_name SEMI
    | USING namespace_or_type_name SEMI
    ;
define_unit
    : DEFINE TYPE IDENTIFIER OP_ASSIGN namespace_or_type_name SEMI
    | DEFINE CONST IDENTIFIER OP_ASSIGN NUMBER SEMI // Replace IDENTIFIER with value
    ;

namespace_or_type_name 
	: (IDENTIFIER type_argument_list?) (DOT IDENTIFIER type_argument_list?)*
	;
method_name
    : any_type? GETTER IDENTIFIER type_argument_list?
    | IDENTIFIER type_argument_list?
    ;

string_value
    : REGULAR_STRING
    | VERBATIUM_STRING
    ;
bool_value
    : BOOL_FALSE
    | BOOL_TRUE
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
	: namespace_or_type_name type_argument_list?
	| TYPE_OBJECT
	| TYPE_STRING
	;

fixed_size_type
    : integral_type
    | TYPE_SIZE
    | TYPE_PTR
    ;

const_type
    : integral_type
    | TYPE_SIZE
    | TYPE_PTR
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