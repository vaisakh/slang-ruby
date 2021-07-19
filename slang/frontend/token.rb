module Token
	ILLEGAL_TOKEN = 'ILLEGAL_TOKEN' # Not a token
	TOK_PLUS = 'TOK_PLUS' # '+'
	TOK_MINUS = 'TOK_MINUS' # '-'
	TOK_MULTIPLY = 'TOK_MULTIPLY' # '*'
	TOK_DIVIDE = 'TOK_DIVIDE' # '/'
	TOK_OPEN_PAREN = 'TOK_OPEN_PAREN' # '('
	TOK_CLOSED_PAREN = 'TOK_CLOSED_PAREN' # ')

	TOK_NULL = 'TOK_NULL' # End of a string
	TOK_PRINT = 'TOK_PRINT' # Print statement
	TOK_PRINTLN = 'TOK_PRINTLN' # PrintLine statement
	TOK_UNQUOTED_STRING = 'TOK_UNQUOTED_STRING' # Variable name, function name
	TOK_SEMI = 'TOK_SEMI' # ';'

	TOK_NUMERIC = 'TOK_NUMERIC' # [0-9]+
	TOK_VAR_NUMBER = 'TOK_VAR_NUMBER' # NUMBER data type
	TOK_VAR_STRING = 'TOK_VAR_STRING' # STRING data type
	TOK_VAR_BOOL = 'TOK_VAR_BOOL' # BOOL data type
	TOK_COMMENT = 'TOK_COMMENT' # COMMENT Token
	TOK_BOOL_TRUE ='TOK_BOOL_TRUE' # Boolean constant TRUE
	TOK_BOOL_FALSE ='TOK_BOOL_FALSE' # Boolean constant false
	TOK_STRING = 'TOK_STRING' # String literal
	TOK_ASSIGN ='TOK_ASSIGN' # Assignment Symbol '='
end