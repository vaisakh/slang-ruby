require_relative 'expression'
require_relative '../../contexts/symbol'
require_relative '../meta/type'


class VariableExpression < Expression
  attr_reader :name
  attr_reader :type

  def initialize(symbol = nil, compilation_context = nil, name = nil, value = nil)
    if symbol
      @name = symbol.name
      return
    end

    s = Symbol.new

    if value.is_a? Numeric
      s.type = Type::NUMERIC
    elsif value.class == TrueClass || value.class == FalseClass
      s.type = Type::BOOLEAN
    elsif value.is_a? String
      s.type = Type::STRING
    else
      raise Exception.new
    end

    s.name = name
    s.type = type
    s.value = value

    compilation_context.add_symbol(s)
    @name = name
  end

  def get_name
    @name
  end

  def evaluate(runtime_context)
    symbol_table = runtime_context.get_symbol_table()
    if symbol_table == nil
      return nil
    else
      symbol_table.get_symbol(@name)
    end
  end

  def type_check(compilation_context)
    symbol_table = compilation_context.get_symbol_table()
    if symbol_table == nil
      return Type::ILLEGAL
    else
      s = symbol_table.get_symbol(@name)
      if(s != nil)
        @type = s.type
        return @type
      end
      return Type::ILLEGAL
    end
  end

  def get_type
    @type
  end

  def accept runtime_context, visitor
    visitor.visit(runtime_context, self)
  end
end