require 'nokogiri'
require 'nwodkram_parser'
class Nwodkram

  attr_accessor :html

  def initialize(html)
    @html = html 
  end

  def to_markdown
    parser = Nokogiri::HTML::SAX::Parser.new(NwodkramParser.new)
    out = StringIO.new
    $stdout = out
    parser.parse(@html)
    out.string
  ensure
    $stdout = STDOUT
  end

end

class String
  def to_markdown
    Nwodkram.new(self).to_markdown
  end
end
