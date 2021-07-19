require_relative './symbol_table'

class RuntimeContext
	attr_reader :symbol_table

	def initialize
		@symbol_table = SymbolTable.new
	end

	def get_symbol_table
		@symbol_table
	end

	def set_symbol_table(symbol_table)
		# = || <<
		@symbol_table << symbol_table
	end
end