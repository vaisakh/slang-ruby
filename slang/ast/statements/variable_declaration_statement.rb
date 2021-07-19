require_relative './statement'
require_relative '../expression/variable_expression'

class VariableDeclarationStatement < Statement
  attr_reader :symbol
  attr_reader :variable

  def initialize(symbol)
    @symbol = symbol  
  end

  def execute(runtime_context)
    symbol_table = runtime_context.get_symbol_table()
    symbol_table.add_symbol(@symbol)
    @variable = VariableExpression.new(@symbol)
    return nil
  end

  def accept runtime_context, visitor
    visitor.visit(runtime_context, self)
  end
end