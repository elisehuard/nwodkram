require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'stringio'

describe "converting html to markdown" do

  it "should not convert text" do
    html = <<-HTML
      hello hello
    HTML
    nwodkram = Nwodkram.new(html)
    str = nwodkram.convert
    str.should == "hello hello\n"
  end

  it "should convert a link" do
    html = <<-HTML
      <a href="http://test.com">test</a>
    HTML
    nwodkram = Nwodkram.new(html)
    str = nwodkram.convert
    str.should == "[test]: http://test.com"
  end

  it "should convert an unordered list" do
    html = <<-HTML
      <ul><li>test</li>
<li>test2</li></ul>
    HTML
    nwodkram = Nwodkram.new(html)
    str = nwodkram.convert
    str.should == "* test\n* test2\n"
  end

  it "should convert an ordered list" do
    html = <<-HTML
      <ol><li>test</li>
<li>test2</li></ol>
    HTML
    nwodkram = Nwodkram.new(html)
    str = nwodkram.convert
    str.should == "1. test\n1. test2\n"
  end

  it "should convert a pre" do
    html = <<-HTML
<pre>
  def test
    p today
  end
</pre>
    HTML
    nwodkram = Nwodkram.new(html)
    str = nwodkram.convert
    str.should == "    def test\n      p today\n    end\n"
  end

  it "should convert a h1 title" do
    html = "<h1>title</h1>\n"
    nwodkram = Nwodkram.new(html)
    str = nwodkram.convert
    str.should == "# title #\n\n"
  end

end
