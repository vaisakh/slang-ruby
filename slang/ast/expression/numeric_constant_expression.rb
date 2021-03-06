require_relative 'expression'
require_relative '../../contexts/symbol'
require_relative '../meta/type'

class NumericConstantExpression < Expression
  attr_reader :value
  attr_reader :symbol


  def initialize(value)
    # @value = value # needs this?

    @symbol = TSymbol.new
    @symbol.name = nil
    @symbol.double_value = value
    @symbol.type = Type::NUMERIC
  end

  def evaluate(runtime_context)
    @symbol
  end

  def type_check(compilation_context)
    @symbol.type
  end

  def get_type()
    @symbol.type
  end

  def accept(visitor)
    visitor.visit(self)
  end
end