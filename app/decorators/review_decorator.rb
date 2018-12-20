module ReviewDecorator
  def display_name
    name? ? "#{name}様" : '名前なし'
  end
end
