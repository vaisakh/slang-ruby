
require_relative '../visitor/visitable'

class Expression < Visitable

  def type_check(compilation_context)
    raise NotImplementedError.new, "#{self.class} #type_check method is abstract and must be implemented in the subclass"
  end

  def get_type
    raise NotImplementedError.new, "#{self.class} #get_type method is abstract and must be implemented in the subclass"
  end
end