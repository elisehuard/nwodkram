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
