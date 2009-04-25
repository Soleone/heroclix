class Symbol
  def to_proc
    proc { |obj, *args| obj.send(self, *args) }
  end
end