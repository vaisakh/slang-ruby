class Statement
  def execute(runtime_context)
    raise NotImplementedError.new, "#{self.class} #execute method is abstract and must be implemented in the subclass"
  end
end