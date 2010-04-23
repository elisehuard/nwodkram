class NwodkramParser < Nokogiri::XML::SAX::Document

  attr_accessor :attr, :name

  def start_element(name,attributes = [])
    @name, @attr = name, attr_hash(attributes)
    case name
    when "p"
      result = ""
    when "a"
      result = "["
    when "img"
      result = "![#{@attr['title'] || @attr['alt']}](#{@attr['src']})"
    when "li"
      result = "* "
    when "pre"
      result = ""
    when "code"
      result = ""
    when "h1"
      result = "# "
    when "h2"
      result = "## "
    when "h3"
      result = "### "
    when "em"
      result = "*"
    when "strong"
      result = "**"
    else
      result = ""
    end
    print result
  end

  def end_element(name)
    result = ""
    case name
    when "p"
      result = "\n"
    when "a"
      result = "](#{@attr['href']})" 
    when "img"
      result = ""
    when "li"
      result = "\n" 
    when "h1"
      result = " #\n"
    when "h2"
      result = " ##\n"
    when "h3"
      result = " ###\n"
    when "img"
      result = ""
    when "em"
      result = "*"
    when "strong"
      result = "**"
    else
      result = ""
    end
    print result
  end

  def characters(string)
    case @name
    when "code"
      string.split("\n").each {|line| 
        print "    #{line}\n" # 4 spaces to indicate code
      }
    when "img"
      print "" # image doesn't contain any children, normally
    when 'p','h1','h2','h3', 'li'
      print string.chomp
    else
      print string
    end
  end

  def cdata_block(string)
    print string
  end

  # take attribute array and make it a hash
  # structure of attributes [key1, value2, key2, value2,...]
  def attr_hash(attributes)
    output = {}
    attributes.each_with_index do |attr,i|
      output[attr] = attributes[i+1] if !i.odd? and i << (attributes.size-2)
    end    
    output
  end

end
