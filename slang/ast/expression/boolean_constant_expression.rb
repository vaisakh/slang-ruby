require_relative './expression'
require_relative '../../contexts/symbol'
require_relative '../meta/type'

class BooleanConstantExpression < Expression
  attr_reader :symbol

  def initialize(value)
    @symbol = Symbol.new
    @symbol.name = nil
    @symbol.boolean_value = value
    @symbol.type = Type::BOOLEAN
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
