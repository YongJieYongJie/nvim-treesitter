; identifiers
; -----------
(identifier) @variable
(yul_identifier) @variable

; Pragma
(pragma_directive) @tag
(solidity_version_comparison_operator _ @tag)

; Literals
; --------

[
 (string)
 (hex_string_literal)
 (unicode_string_literal)
 (yul_string_literal)
] @string
[
 (number_literal)
 (yul_decimal_number)
 (yul_hex_number)
] @number
[
 (true)
 (false)
] @constant.builtin

(comment) @comment

; Definitions and references
; -----------

(type_name) @type
(primitive_type) @type
; (user_defined_type (identifier) @type) ; YJ: problem with upstream

(payable_conversion_expression "payable" @type)
; Ensures that delimiters in mapping( ... => .. ) are not colored like types
(type_name "(" @punctuation.bracket "=>" @punctuation.delimiter ")" @punctuation.bracket)

; Definitions
(struct_declaration 
  struct_name: (identifier) @type)
(enum_declaration 
  enum_type_name: (identifier) @type)
(contract_declaration
  name: (identifier) @type) 
(library_declaration
  name: (identifier) @type) 
(interface_declaration
  name: (identifier) @type)
(event_definition 
  name: (identifier) @type) 

(function_definition
  function_name:  (identifier) @function)

(modifier_definition
  name:  (identifier) @function)
(yul_evm_builtin) @function.builtin

; Use contructor coloring for special functions
(constructor_definition "constructor" @constructor)
(fallback_receive_definition "receive" @constructor)
(fallback_receive_definition "fallback" @constructor)

(struct_member name: (identifier) @property)
(enum_value) @constant

; Invocations 
(emit_statement . (identifier) @type)
(modifier_invocation (identifier) @function)

(call_expression . (member_expression property: (property_identifier) @function.method))
(call_expression . (identifier) @function)

; Function parameters
; (call_argument name: (identifier) @field)
(event_paramater name: (identifier) @parameter)
(parameter name: (identifier) @variable.parameter)

; ; Yul functions
(yul_function_call function: (yul_identifier) @function)
(yul_function_definition . (yul_identifier) @function (yul_identifier) @parameter)


; ; Structs and members
(member_expression property: (property_identifier) @property)
(struct_expression . ((identifier) @type .))
; (struct_field_assignment name: (identifier) @property)


; Tokens
; -------

; Keywords
(meta_type_expression "type" @keyword)
; Keywords
[
 "pragma"
 "contract"
 "interface"
 "library"
 "is"
 "struct"
 "enum"
 "event"
 "using"
 "assembly"
 "emit"
 "public"
 "internal"
 "private"
 "external"
 "pure"
 "view"
 "payable"
 "modifier"
 "memory"
 "storage"
 "calldata"
 "var"
 ; "constant"
 (virtual)
 (override_specifier)
 (yul_leave)
] @keyword

[
 "for"
 "while"
 "do"
] @repeat

[
 "break"
 "continue"
 "if"
 "else"
 "switch"
 "case"
 "default"
] @conditional

[
 "try"
 "catch"
] @exception

[
 "return"
 "returns"
] @keyword.return

"function" @keyword.function

"import" @include
(import_directive "as" @include)
(import_directive "from" @include)

(event_paramater "indexed" @keyword)

; Punctuation

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket


[
  "."
  ","
] @punctuation.delimiter


; Operators

[
  "&&"
  "||"
  ">>"
  ">>>"
  "<<"
  "&"
  "^"
  "|"
  "+"
  "-"
  "*"
  "/"
  "%"
  "**"
  "<"
  "<="
  "=="
  "!="
  "!=="
  ">="
  ">"
  "!"
  "~"
  "-"
  "+"
  "++"
  "--"
] @operator

[
  "delete"
  "new"
] @keyword.operator

; BREAK

; (comment) @comment
; ;; Handles natspec comments
; ((comment) @preproc
;  (#match? @preproc "^/// .*"))

; ; Pragma
; (pragma_directive) @attribute


; ; Literals
; [
;  (string)
;  (hex_string_literal)
;  (unicode_string_literal)
;  (yul_string_literal)
; ] @string
; [
;  (number_literal)
;  (yul_decimal_number)
;  (yul_hex_number)
; ] @number
; [
;  (true)
;  (false)
; ] @constant.builtin


; ; Type
; (type_name (identifier) @type)
; (type_name "mapping" @type)
; (primitive_type) @type
; (contract_declaration name: (identifier) @type)
; (struct_declaration struct_name: (identifier) @type)
; (struct_member name: (identifier) @field)
; (enum_declaration enum_type_name: (identifier) @type)
; (emit_statement . (identifier) @type)
; ; Handles ContractA, ContractB in function foo() override(ContractA, contractB) {}
; (override_specifier (identifier) @type)
; ; Ensures that delimiters in mapping( ... => .. ) are not colored like types
; (type_name
;   "(" @punctuation.bracket
;   "=>" @punctuation.delimiter
;   ")" @punctuation.bracket)


; ; Functions and parameters

; (function_definition
;   function_name:  (identifier) @function)
; (modifier_definition
;   name:  (identifier) @function)
; (yul_evm_builtin) @function.builtin

; ; Use contructor coloring for special functions
; (constructor_definition "constructor" @constructor)
; (fallback_receive_definition "receive" @constructor)
; (fallback_receive_definition "fallback" @constructor)

; (modifier_invocation (identifier) @function)

; ; Handles expressions like structVariable.g();
; (call_expression . (member_expression (property_identifier) @method.call))

; ; Handles expressions like g();
; (call_expression . (identifier) @function.call)
; (function_definition
;  function_name: (identifier) @function)

; ; Handles the field in struct literals like MyStruct({MyField: MyVar * 2})
; (call_expression (identifier) @field . ":")

; ; Function parameters
; (event_paramater name: (identifier) @parameter)
; (parameter name: (identifier) @parameter)

; ; Yul functions
; (yul_function_call function: (yul_identifier) @function.call)

; ; Yul function parameters
; (yul_function_definition . (yul_identifier) @function (yul_identifier) @parameter)

; (meta_type_expression "type" @keyword)

; (member_expression (property_identifier) @field)
; (property_identifier) @field
; (struct_expression ((identifier) @field . ":"))
; (enum_value) @constant


; ; Keywords
; [
;  "contract"
;  "interface"
;  "library"
;  "is"
;  "struct"
;  "enum"
;  "event"
;  "assembly"
;  "emit"
;  "modifier"
;  "var"
;  (virtual)
;  (override_specifier)
;  (yul_leave)
; ] @keyword

; [
;  "public"
;  "internal"
;  "private"
;  "external"
;  "pure"
;  "view"
;  "payable"
; ] @type.qualifier

; [
;  "memory"
;  "storage"
;  "calldata"
;  (constant)
; ] @storageclass

; [
;  "for"
;  "while"
;  "do"
; ] @repeat

; [
;  "break"
;  "continue"
;  "if"
;  "else"
;  "switch"
;  "case"
;  "default"
; ] @conditional

; [
;  "try"
;  "catch"
; ] @exception

; [
;  "return"
;  "returns"
; ] @keyword.return

; "function" @keyword.function

; "pragma" @preproc

; ["import" "using"] @include
; (import_directive "as" @include)
; (import_directive "from" @include)

; (event_paramater "indexed" @keyword)

; ; Punctuation

; [
;   "("
;   ")"
;   "["
;   "]"
;   "{"
;   "}"
; ] @punctuation.bracket


; [
;   "."
;   ","
; ] @punctuation.delimiter


; ; Operators

; [
;   "&&"
;   "||"
;   ">>"
;   ">>>"
;   "<<"
;   "&"
;   "^"
;   "|"
;   "+"
;   "-"
;   "*"
;   "/"
;   "%"
;   "**"
;   "<"
;   "<="
;   "=="
;   "!="
;   "!=="
;   ">="
;   ">"
;   "!"
;   "~"
;   "-"
;   "+"
;   "++"
;   "--"
; ] @operator

; [
;   "delete"
;   "new"
; ] @keyword.operator

; (identifier) @variable
; (yul_identifier) @variable
