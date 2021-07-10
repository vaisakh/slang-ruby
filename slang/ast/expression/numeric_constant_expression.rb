require_relative 'expression'

class NumericConstantExpression < Expression
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def accept(visitor)
    visitor.visit(self)
  end
end