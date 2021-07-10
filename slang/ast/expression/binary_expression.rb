require_relative 'expression'
require_relative '../meta/operator'

class BinaryExpression < Expression
  attr_reader :l_expression, :r_expression, :operator

  def initialize(l_expression, r_expression, operator)
    @l_expression = l_expression
    @r_expression = r_expression
    @operator = operator
  end
  
  def get_operator
    @operator
  end

  def get_left_expression
    @l_expression
  end

  def get_right_expression
    @r_expression
  end

  def accept visitor
    visitor.visit(self)
  end
end
