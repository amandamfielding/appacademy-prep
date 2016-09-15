class XmlDocument
  attr_reader :indent_depth
  def initialize(indent = false)
    @indent = indent
    @indent_depth = 0
  end
  
  def method_missing(name,*attrs,&blk)
    attrs = attrs.first || {}
    render_tag(name, attrs, &blk)
  end
  
  def attribute_strings(attrs)
    attrs.map {|k,v| "#{k}=\"#{v}\""}
  end
  
  def tag_body(name, attrs)
    ([name] + attribute_strings(attrs)).join(" ")
  end
  
  def render_tag(name,attrs,&blk)
    xml = ""
    if block_given?
      xml << "#{open_tag(name, attrs)}"
      indent
      xml << blk.call
      unindent
      xml << "#{closing_tag(name)}"
    else
      xml << lone_tag(name, attrs)
    end
  end
  
  def indent
    @indent_depth += 1 if @indent
  end
  def unindent
    @indent_depth -= 1 if @indent
  end
  
  def open_tag(name, attrs)
    "#{tabspace}<#{tag_body(name, attrs)}>#{newline}"
  end
  
  def lone_tag(name, attrs)
    "#{tabspace}<#{tag_body(name, attrs)}/>#{newline}"
  end
  
  def closing_tag(name)
    "#{tabspace}</#{name}>#{newline}"
  end
  
  def newline
    @indent ? "\n" : ""
  end
  
  def tabspace
    "  " * indent_depth
  end
end