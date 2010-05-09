class NwodkramParser < Nokogiri::XML::SAX::Document

  attr_accessor :attr, :name

  MARKDOWN = { 'p'      => [""                                                               , "\n"],
               'a'      => ["["                                                              , lambda { "](#{@attr['href']})" }],
               'img'    => [ lambda {"![#{@attr['title'] || @attr['alt']}](#{@attr['src']})"}, ""],
               'li'     => [ lambda { @parent == "ul" ? "* " : "1. " }                       , "\n"],
               'code'   => [""                                                               , ""],
               'h1'     => ["# "                                                             , " #\n" ],
               'h2'     => ["## "                                                            , " ##\n" ],
               'h3'     => ["### "                                                           , " ###\n"],
               'em'     => ["*"                                                              , "*"],
               'strong' => ["**"                                                             , "**"] }

  def start_element(name,attributes = [])
    @name, @attr = name, attr_hash(attributes)
    MARKDOWN[name] ? print(local_value(MARKDOWN[name][0])) : print("")
    track_parent
  end

  def end_element(name)
    MARKDOWN[name] ? print(local_value(MARKDOWN[name][1])) : print("")
  end

  # content of the markup
  def characters(string)
    case @name
    when "code"
      string.split("\n").each {|line| 
        print "    #{line}\n" # 4 spaces to indicate code
      }
    when "img"
      print "" # image doesn't contain any children, normally
    when 'p','h1','h2','h3', 'li', 'ul','ol'
      print string.chomp
    else
      # getting rid of annoying newlines
      string[0] == 10 ? print("\n") : print(string)
    end
  end

  def cdata_block(string)
    print string
  end

private
  # way to handle the start and end of elements - local evaluation if the value is a proc
  def local_value(value)
    value.is_a?(Proc) ? instance_eval(&value) : value
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

  # for ul and ol, it's necessary to keep track of which is which
  def track_parent
    @parent = @name unless @name == 'li'
  end

end
