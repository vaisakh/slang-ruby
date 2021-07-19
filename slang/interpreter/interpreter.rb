require_relative '../ast/visitor/visitor'

class Interpreter < Visitor
  
  def visit_NumericConstantExpression subject
    subject.value
  end

  def visit_UnaryExpression subject
    case subject.operator
    when Operator::PLUS then subject.get_expression().accept(self)
    when Operator::MINUS then - subject.get_expression().accept(self)
    end
  end

  def visit_BinaryExpression subject
    operator = subject.get_operator()
    l_expression_value = subject.get_left_expression().accept(self)
    r_expression_value = subject.get_right_expression().accept(self)

    case operator
    when Operator::PLUS then l_expression_value + r_expression_value
    when Operator::MINUS then l_expression_value - r_expression_value
    when Operator::DIVIDE then l_expression_value / r_expression_value
    when Operator::MULTIPLY then l_expression_value * r_expression_value
    end
  end

  def visit_PrintlineStatement runtime_context, subject
    value = subject.get_expression().accept(runtime_context, self)
    puts value.to_s
  end

  def visit_PrintStatement subject
    value = subject.get_expression().accept(self)
    print value.to_s
  end

  def visit_BooleanConstantExpression subject
    puts 'visit_BooleanConstantExpression'
  end

  def visit_VariableDeclarationStatement runtime_context, subject
    puts 'visit_VariableDeclarationStatement'
    # symbol_table = runtime_context.get_symbol_table()
    # symbol_table.add_symbol(@symbol)
    # @variable = VariableExpression.new(@symbol)
    # return nil
  end
  
  def visit_AssignmentStatement runtime_context, subject
    puts 'visit_AssignmentStatement'
  end

  def visit_VariableExpression runtime_context, subject
    puts 'visit_VariableExpression'
  end
end