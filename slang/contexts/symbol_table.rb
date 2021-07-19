require_relative '../ast/expression/variable_expression'

class SymbolTable
  attr_reader :symbol_table

  def initialize
    @symbol_table = Hash.new
  end

  def add_symbol(symbol)
    @symbol_table[symbol.name] = symbol
  end

  def get_symbol(name)
    @symbol_table[name]
  end

  def assign(variable, symbol)
    if(variable.instance_of? String)
      @symbol_table[variable] = symbol
    elsif variable.instance_of? VariableExpression
      symbol.name = variable.get_name()
      @symbol_table[variable.get_name()] = symbol
    end
  end
end