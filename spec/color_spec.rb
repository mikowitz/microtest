require File.join(File.dirname(__FILE__), %w[spec_helper])

describe Microtest::Color do
  it "should return the correct value for Color.red" do
    Microtest::Color.write_with_color(:red, "ok").should == "\e[31mok\e[0m"
  end

  it "should return the correct value for Color.green" do
    Microtest::Color.write_with_color(:green, "ok").should == "\e[32mok\e[0m"
  end
  
  it "should return the correct value for Color.yellow" do
    Microtest::Color.write_with_color(:yellow, "ok").should == "\e[33mok\e[0m"
  end

  it "should return the correct value for Color.cyan" do
    Microtest::Color.write_with_color(:cyan, "ok").should == "\e[36mok\e[0m"
  end
 
  it "should return the correct value for Color.blue (not defined in ANSI)" do
    Microtest::Color.write_with_color(:blue, "ok").should == "\e[0mok\e[0m"
  end
end