require_relative './statement'

class PrintlineStatement < Statement
  attr_reader :expression

  def initialize(expression)
    @expression = expression
  end

  def get_expression
    @expression
  end

  def accept visitor
    visitor.visit(self)
  end
end