require_relative './token'
require_relative '../ast/meta/value_table'

class Lexer
	attr_reader	:expression
	attr_reader	:cursor
	attr_reader	:length
	attr_reader	:number
  attr_reader :current_token
  attr_reader :last_token;
  attr_reader :last_str

	def initialize(expression)
		@expression = expression
		@length = expression.length
		@cursor = 0
	end

	def get_next
		@last_token = @current_token
		@current_token = get_token()
	end

	def get_token
		token = Token::ILLEGAL_TOKEN

		# Skip white space  & new line characters
		while @cursor < @length && is_white_space?(@expression[@cursor])
			@cursor += 1
		end

		# End of string? return null
		if @cursor == @length
			return Token::TOK_NULL
		end

		case @expression[@cursor]
		when '+'
			token = Token::TOK_PLUS
			@cursor +=1
		when '-'
			token = Token::TOK_MINUS
			@cursor +=1
		when '/'
			token = Token::TOK_DIVIDE
			@cursor +=1
		when '*'
			token = Token::TOK_MULTIPLY
			@cursor +=1
		when '('
			token = Token::TOK_OPEN_PAREN
			@cursor +=1
		when ')'
			token = Token::TOK_CLOSED_PAREN
			@cursor +=1
		when ';'
			token = Token::TOK_SEMI
			@cursor += 1
		when '='
			token = Token::TOK_ASSIGN
			@cursor += 1
		when /[0-9]/
			str = ""
			while @cursor < @length && is_digit?(@expression[@cursor])
				str += @expression[@cursor]
				@cursor += 1 
			end

			@number = str.to_i
			token = Token::TOK_NUMERIC
		when /[a-zA-Z]$/
			str = ""
			while @cursor < @length && is_alpha_numeric?(@expression[@cursor])
				str += @expression[@cursor]
				@cursor += 1
			end

			str = str.upcase
			if(ValueTable.member? str)
				token = ValueTable[str.upcase]
				return token
			end

			@last_str = str
			return Token::TOK_UNQUOTED_STRING
		else
			raise Exception.new "Error while analyzing tokens"
		end
		return token
	end
	
	def is_alpha_numeric?(char)
		(char =~ /[a-zA-Z0-9]/) ? true : false
	end

	def is_digit?(char)
		(char =~ /[0-9]/) ? true : false
	end

	def is_white_space?(char)
		(char =~ /[\s\t\r\n\f]/) ? true: false
	end

	def get_number
		@number
	end
end