require_relative '../frontend/rd_parser'

class ExpressionBuilder
  attr_reader :expression_string

  def initialize(str)
    @expression_string = str
  end

  def get_expression
    begin
      parser = RDParser.new(@expression_string)
      parser.call_expression()
    rescue StandardError => e
      nil
    end
  end
end