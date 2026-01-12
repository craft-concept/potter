class Module
  def define_class(name, parent = nil, &)
    name = name.to_s.camelize
    raise NameError, "class exists" if const_defined? name
    const_set name, Class.new(parent, &)
  end

  def const_cache(name)
    name = name.to_s.gsub('::', ?_)
    const_defined?(name, false) ? const_get(name) : const_set(name, yield(name))
  end
end
