require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'stringio'

# Issue: BlueCloth surrounds every bit of html with a
describe "converting html to markdown" do

  it "should not convert simple text" do
    markdown = "hello hello\n"
    html = markdown.to_html
    html.to_markdown.should == markdown
  end

  it "should convert emphasis" do
    markdown = "*NO* smoking\n"
    html = markdown.to_html
    html.to_markdown.should == markdown
  end

  it "should convert strong" do
    markdown = "I was **born** under a wandering star\n"
    html = markdown.to_html
    html.to_markdown.should == markdown
  end

  it "should convert a link" do
    markdown = "my favourite site [test](http://test.com) because it rules\n"
    html = markdown.to_html
    html.to_markdown.should == markdown
  end

  it "should convert an image" do
    markdown = "![title](http://test.com/lalala.jpg)\n"
    html = markdown.to_html
    html.to_markdown.should == markdown
  end

  it "should convert an unordered list" do
    markdown = "* test\n* test2\n"
    html = markdown.to_html
    html.to_markdown.should == markdown
  end

  it "should convert an ordered list" do
    markdown = "1. test\n1. test2\n"
    html = markdown.to_html
    html.to_markdown.should == markdown
  end

  it "should convert a pre" do
    markdown = "    def test\n      p today\n    end\n"
    html = markdown.to_html
    html.to_markdown.should == markdown
  end

  it "should convert a h1 title" do
    markdown = "# title #\n"
    html = markdown.to_html
    html.to_markdown.should == markdown
  end

  it "should convert a h3 title" do
    markdown = "### title ###\n"
    html = markdown.to_html
    html.to_markdown.should == markdown
  end

  it "should convert a blockquote" do
    markdown = "> boo !\n\n that was scary\n"
    html = markdown.to_html
    html.to_markdown.should == markdown
  end

  it "should convert a text with several bits of code" do
    html = File.open(File.expand_path(File.dirname(__FILE__) + "/code_test.txt")).read
    markdown = html.to_markdown
    markdown.to_html.should == html
  end

  # the ultimate test: convert the readme
  it "should convert a whole text" do
    markdown = File.open(File.expand_path(File.dirname(__FILE__) + "/../README.md")).read
    html = markdown.to_html
    html.to_markdown.should == markdown
  end

end

