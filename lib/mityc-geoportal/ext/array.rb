class Array
  def by_attribute(attr_name)
    group_by_attribute(attr_name)
    groups_by_attribute.each { |attr_value, items| yield attr_value, items }
  end

  protected
    def group_by_attribute(attr_name)
      self.groups_by_attribute = {}
      self.each { |item|
        attr_value = item.send(attr_name.to_sym)
        self.groups_by_attribute[attr_value] ||= []
        self.groups_by_attribute[attr_value] << item
      }
    end

    attr_accessor :groups_by_attribute
end