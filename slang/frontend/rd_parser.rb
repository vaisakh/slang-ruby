require_relative './lexer'
require_relative './token'
require_relative '../ast/meta/type'
require_relative '../contexts/symbol'
require_relative '../ast/meta/operator'
require_relative '../ast/expression/numeric_constant_expression'
require_relative '../ast/expression/unary_expression'
require_relative '../ast/expression/binary_expression'
require_relative '../ast/statements/printline_statement'
require_relative '../ast/statements/print_statement'
require_relative '../ast/statements/variable_declaration_statement'
require_relative '../ast/statements/assignment_statement'
require_relative '../ast/expression/string_literal_expression'
require_relative '../ast/expression/boolean_constant_expression'
require_relative '../ast/expression/variable_expression'


class RDParser < Lexer

  def initialize(str)
    super(str)
  end

  def parse(compilation_context)
    get_next()
    get_statement_list(compilation_context)
  end

  # <stmtlist> := { <statement> }+
  def get_statement_list(compilation_context)
    statements = []
    while(@current_token != Token::TOK_NULL)
      statement = parse_statement(compilation_context)
      if(statement != nil)
        statements.append(statement)
      end
    end
    statements
  end

  # <statement> := <printstmt> | <printlinestmt>
  def parse_statement(compilation_context)
    statement = nil
    case @current_token
    when Token::TOK_PRINT
      statement = parse_print_statement(compilation_context)
      @current_token = get_token()
    when Token::TOK_PRINTLN
      statement = parse_print_line_statement(compilation_context)
      @current_token = get_token()
    when Token::TOK_VAR_NUMBER, Token::TOK_VAR_STRING, Token::TOK_VAR_BOOL
      statement = parse_variable_declaration_statement(compilation_context)
      get_next()
      statement
    when Token::TOK_UNQUOTED_STRING
      statement = parse_assignment_statement(compilation_context)
      get_next()
      statement
    else
      raise Exception.new "Invalid statement"
    end
    statement
  end

  # <printstmt> := print <expr>;
  def parse_print_statement(compilation_context)
    @current_token = get_token()
    expression = parseExpression()
    if(@current_token != Token::TOK_SEMI)
      raise Exception.new "; expected"
    end
    PrintStatement.new(expression)
  end

  # <printlinestmt>:= printline <expr>;
  def parse_print_line_statement(compilation_context)
    @current_token = get_token()
    expression = parseExpression(compilation_context)
    if(@current_token != Token::TOK_SEMI)
      raise Exception.new "; expected"
    end
    PrintlineStatement.new(expression)
  end

  # <vardeclstmt> := STRING <varname>; | NUMERIC <varname>; | BOOLEAN <varname>;
  def parse_variable_declaration_statement(compilation_context)
    token = @current_token
    get_next()
    if(@current_token == Token::TOK_UNQUOTED_STRING)
      symbol = TSymbol.new
      symbol.name = @last_str
      symbol.type = (token == Token::TOK_VAR_BOOL) ? Type::BOOLEAN : (token == Token::TOK_VAR_NUMBER) ? Type::NUMERIC : Type::STRING
      get_next()

      if(@current_token == Token::TOK_SEMI)
        symbol_table = compilation_context.get_symbol_table()
        symbol_table.add_symbol(symbol)
        return VariableDeclarationStatement.new(symbol)
      else
        puts '; expected'
        # TODO
        # CSyntaxErrorLog.AddLine("; expected");
        # CSyntaxErrorLog.AddLine(GetCurrentLine(SaveIndex()));
        # throw new CParserException(-100, ", or ; expected", SaveIndex());
      end
    else
      puts 'invalid variable declaration'
      # TODO
      # CSyntaxErrorLog.AddLine("invalid variable declaration"); 
      # CSyntaxErrorLog.AddLine(GetCurrentLine(SaveIndex()));
      # throw new CParserException(-100, ", or ; expected", SaveIndex());
    end
  end

  # <variable> = <expr>
  def parse_assignment_statement(compilation_context)
    variable = @last_str
    symbol = compilation_context.get_symbol_table().get_symbol(variable)
    if(symbol == nil)
      puts 'variable not found'
      # TODO
      # CSyntaxErrorLog.AddLine("Variable not found " + last_str);
      # CSyntaxErrorLog.AddLine(GetCurrentLine(SaveIndex()));
      # throw new CParserException(-100, "Variable not found", SaveIndex());
    end
    
    get_next()
    if(@current_token != Token::TOK_ASSIGN)
      # TODO
      # CSyntaxErrorLog.AddLine("= expected"); 
      # CSyntaxErrorLog.AddLine(GetCurrentLine(SaveIndex())); t
      # throw new CParserException(-100, "= expected", SaveIndex());
    end

    get_next()
    expression = parseExpression(compilation_context)
    if(expression.type_check(compilation_context) != symbol.type)
      puts 'Type mismatch in assignment'
      # TODO
      # throw new Exception("Type mismatch in assignment");
    end

    if(@current_token != Token::TOK_SEMI)
      puts '; expected'
      # TODO
      # CSyntaxErrorLog.AddLine("; expected"); 
      # CSyntaxErrorLog.AddLine(GetCurrentLine(SaveIndex())); 
      # throw new CParserException(-100, " ; expected", -1);
    end
    AssignmentStatement.new(symbol, expression)
  end

  def call_expression
    @current_token = get_token()
    parseExpression()
  end

  # <Expr> ::= <Term> | <Term> { + | - } <Expr>
  def parseExpression(compilation_context)
    expression = parseTerm(compilation_context)
    while @current_token == Token::TOK_PLUS || @current_token == Token::TOK_MINUS
      operator_token = @current_token
      @current_token = get_token()

      exp = parseExpression()
      operator_token = operator_token == Token::TOK_PLUS ? Operator::PLUS : Operator::MINUS
      expression = BinaryExpression.new(expression, exp, operator_token)
    end
    expression
  end

  # <Term> ::= <Factor> | <Factor> {*|/} <Term>
  def parseTerm(compilation_context)
    expression = parseFactor(compilation_context)
    while @current_token == Token::TOK_MULTIPLY || @current_token == Token::TOK_DIVIDE
      operator_token = @current_token
      @current_token = get_token()

      exp = parseTerm()
      operator_token = operator_token == Token::TOK_MULTIPLY ? Operator::MULTIPLY : Operator::DIVIDE
      expression = BinaryExpression.new(expression, exp, operator_token)
    end
    expression
  end

  # <Factor>::= <number> | ( <expr> ) | {+|-} <factor>
  def parseFactor(compilation_context)
    expression = nil
    if(@current_token == Token::TOK_NUMERIC)
      expression = NumericConstantExpression.new(get_number())
      @current_token = get_token()
    elsif @current_token == Token::TOK_STRING
      expression = StringLiteralExpression.new(@last_str)
      @current_token = get_token()
    elsif @current_token == Token::TOK_BOOL_FALSE || @current_token == Token::TOK_BOOL_TRUE
      token = Token::TOK_BOOL_TRUE ? true : false
      expression = BooleanConstantExpression.new(token)
      @current_token = get_token()
    elsif @current_token == Token::TOK_OPEN_PAREN
      @current_token = get_token()
      expression = parseExpression()

      if(@current_token != Token::TOK_CLOSED_PAREN)
        raise Exception.new "Missing closing parenthesis"
      end
      @current_token = get_token()
    elsif @current_token == Token::TOK_PLUS || @current_token == Token::TOK_MINUS
      operator_token = @current_token
      @current_token = get_token()

      expression = parseFactor()
      operator_token = operator_token == Token::TOK_PLUS ? Operator::PLUS : Operator::MINUS
      expression = UnaryExpression.new(expression, operator_token)
    elsif @current_token == Token::TOK_UNQUOTED_STRING
      symbol = compilation_context.get_symbol_table().get_symbol(@last_str)
      if(symbol == nil)
        puts 'Undefined symbol'
        # TODO
        # throw new Exception("Undefined symbol");
      end
      get_next()
      expression = VariableExpression.new(symbol)
    else
      raise Exception.new "Illegal token"
    end
    expression
  end
end
