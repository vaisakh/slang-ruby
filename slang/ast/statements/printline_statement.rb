require_relative './statement'

class PrintlineStatement < Statement
  attr_reader :expression

  def initialize(expression)
    @expression = expression
  end

  def get_expression
    @expression
  end

  def accept runtime_context, visitor
    visitor.visit(runtime_context, self)
  end
end