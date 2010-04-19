class NwodkramParser < Nokogiri::XML::SAX::Document

  attr_accessor :attr, :name

  def start_element(name,attributes = [])
    @name, @attr = name, attributes
    result = ""
    case name
    when "a"
      result = markdown_link_start(attributes)
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
    when "a"
      result = markdown_link_end
    when "li"
      result = "\n" 
    when "h1"
      result = " #\n\n"
    when "h2"
      result = " ##\n\n"
    else
      result = ""
    end
    print result
  end

  def characters(string)
    case @name
    when "li"
      print string.chomp
    when "pre"
      string.split("\n").each {|line| 
        if line.chomp =~ /^$/
          print ""
        else
          print "    #{line.lstrip}\n"
        end
      }
    else
      print string
    end
  end

  def cdata_block(string)
    print string
  end


  def markdown_link_start(attributes)
    "["
  end

  def markdown_link_end
    # puts "]: #{attributes[1]}"
    "]: #{@attr[1]}" 
  end

end
