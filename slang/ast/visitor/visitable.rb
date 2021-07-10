class Visitable
  def accept(visitor)
    raise NotImplementedError.new, "#{self.class} #accept method is abstract and must be implemented in the subclass"
  end
end