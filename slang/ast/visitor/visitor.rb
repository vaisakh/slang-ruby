class Visitor
  def visit context, subject
    method_name = "visit_#{subject.class}".intern
    send(method_name, context, subject )
  end
end