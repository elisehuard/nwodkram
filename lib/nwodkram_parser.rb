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
      result = "!["
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
      result = "](#{@attr[1]})" 
    when "img"
      result = "](#{@attr[1]})" 
    when "li"
      result = "\n" 
    when "h1"
      result = " #\n\n"
    when "h2"
      result = " ##\n\n"
    when "img"
      result = ""
    else
      result = ""
    end
    print result
  end

  def characters(string)
    case @name
    when "li", "ul", "ol"
      print string.chomp
    when "code"
      string.split("\n").each {|line| 
        print "    #{line}\n" # 4 spaces to indicate code
      }
    else
      print string
    end
  end

  def cdata_block(string)
    print string
  end

  # take attribute array and make it a hash
  def attr_hash(attributes)
    
  end

end
