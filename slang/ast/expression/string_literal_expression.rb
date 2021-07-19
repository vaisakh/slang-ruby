require_relative './expression'
require_relative '../../contexts/symbol'
require_relative '../meta/type'

class StringLiteralExpression
  attr_reader :symbol

  def initialize(value)
    @symbol = Symbol.new
    @symbol.name = nil
    @symbol.string_value = value
    @symbol.type = Type::STRING
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