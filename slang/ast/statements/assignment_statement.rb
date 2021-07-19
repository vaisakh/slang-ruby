require_relative './statement'
require_relative '../expression/variable_expression'
require_relative '../../contexts/symbol'

class AssignmentStatement < Statement
  attr_reader :expression
  attr_reader :variable


  def initialize(variable, expression)
    if(variable.instance_of? VariableExpression)
      @variable = variable_expression
      @expression = expression
    elsif variable.instance_of? TSymbol
      @variable = VariableExpression.new(variable)
      @expression = expression
    end
  end

  def execute(runtime_context)
    value = @expression.evaluate(runtime_context)
    symbol_table = runtime_context.get_symbol_table()
    symbol_table.assign(@variable, value)
    nil
  end

  def accept runtime_context, visitor
    visitor.visit(runtime_context, self)
  end
end