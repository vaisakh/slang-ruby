class Visitable
  def accept(context, visitor)
    raise NotImplementedError.new, "#{self.class} #accept method is abstract and must be implemented in the subclass"
  end
end