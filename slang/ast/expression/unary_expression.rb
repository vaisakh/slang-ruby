require_relative 'expression'
require_relative '../meta/operator'

class UnaryExpression < Expression
  attr_reader :expression, :operator

  def initialize(exp, op)
    @expression = exp
    @operator = op
  end

  def get_operator
    @operator
  end

  def get_expression
    @expression
  end

  def accept visitor
    visitor.visit(self)
  end
end
