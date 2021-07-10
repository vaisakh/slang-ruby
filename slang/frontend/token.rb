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
end