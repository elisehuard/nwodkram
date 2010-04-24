dir = File.dirname(__FILE__)
$LOAD_PATH.unshift "#{dir}/../lib"

require 'rubygems'
require 'spec'
require 'nwodkram'
require 'bluecloth' # markdown converter to test against
require 'rspec/matchers'

Spec::Runner.configure do |config|
end

class String
  def to_html
    bc = BlueCloth.new(self)
    bc.to_html
  end

  def to_markdown
    nk = Nwodkram.new(self)
    nk.to_markdown 
  end
end

Rspec::Matchers.define :convert_to_html_and_back do
  match do |markdown|
    html = markdown.to_html
    html.to_markdown == markdown
  end
end
