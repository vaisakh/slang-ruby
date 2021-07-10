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

  def visit_PrintlineStatement subject
    value = subject.get_expression().accept(self)
    puts value.to_s
  end

  def visit_PrintStatement subject
    value = subject.get_expression().accept(self)
    print value.to_s
  end
end
