require_relative './lexer'
require_relative './token'
require_relative '../ast/meta/operator'
require_relative '../ast/expression/numeric_constant_expression'
require_relative '../ast/expression/unary_expression'
require_relative '../ast/expression/binary_expression'
require_relative '../ast/statements/printline_statement'
require_relative '../ast/statements/print_statement'


class RDParser < Lexer
  attr_reader :current_token

  def initialize(str)
    super(str)
  end

  def parse
    # get_next()
    @current_token = get_token()
    get_statement_list()
  end

  def get_statement_list
    statements = []
    while(@current_token != Token::TOK_NULL)
      statement = parse_statement()
      if(statement != nil)
        statements.append(statement)
      end
    end
    statements
  end

  def parse_statement
    statement = nil
    case @current_token
    when Token::TOK_PRINT
      statement = parse_print_statement()
      @current_token = get_token()
    when Token::TOK_PRINTLN
      statement = parse_print_line_statement()
      @current_token = get_token()
    else
      raise Exception.new "Invalid statement"
    end
    statement
  end

  def parse_print_statement
    @current_token = get_token()
    expression = Expr()
    if(@current_token != Token::TOK_SEMI)
      raise Exception.new ": expected"
    end
    PrintStatement.new(expression)
  end

  def parse_print_line_statement
    @current_token = get_token()
    expression = Expr()
    if(@current_token != Token::TOK_SEMI)
      raise Exception.new "; expected"
    end
    PrintlineStatement.new(expression)
  end

  def call_expression
    @current_token = get_token()
    Expr()
  end

  def Expr
    returnValue = Term()
    while @current_token == Token::TOK_PLUS || @current_token == Token::TOK_MINUS
      operator_token = @current_token
      @current_token = get_token()

      exp = Expr()
      operator_token = operator_token == Token::TOK_PLUS ? Operator::PLUS : Operator::MINUS
      returnValue = BinaryExpression.new(returnValue, exp, operator_token)
    end
    returnValue
  end

  def Term
    returnValue = Factor()
    while @current_token == Token::TOK_MULTIPLY || @current_token == Token::TOK_DIVIDE
      operator_token = @current_token
      @current_token = get_token()

      exp = Term()
      operator_token = operator_token == Token::TOK_MULTIPLY ? Operator::MULTIPLY : Operator::DIVIDE
      returnValue = BinaryExpression.new(returnValue, exp, operator_token)
    end
    returnValue
  end

  def Factor
    returnValue = nil
    if(@current_token == Token::TOK_NUMERIC)
      returnValue = NumericConstantExpression.new(get_number())
      @current_token = get_token()
    elsif @current_token == Token::TOK_OPEN_PAREN
      @current_token = get_token()
      returnValue = Expr()

      if(@current_token != Token::TOK_CLOSED_PAREN)
        raise Exception.new "Missing closing parenthesis"
      end
      @current_token = get_token()
    elsif @current_token == Token::TOK_PLUS || @current_token == Token::TOK_MINUS
      operator_token = @current_token
      @current_token = get_token()
      
      returnValue = Factor()
      operator_token = operator_token == Token::TOK_PLUS ? Operator::PLUS : Operator::MINUS
      returnValue = UnaryExpression.new(returnValue, operator_token)
      returnValue
    else
      raise Exception.new "Illegal token"
    end
    returnValue
  end
end