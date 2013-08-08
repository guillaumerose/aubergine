require File.dirname(__FILE__) + '/../test_helper'

describe Courgette::Processors::DefaultProcessor do
  include Ramcrest::Is

  it "removes carriage return" do
    processor = Courgette::Processors::DefaultProcessor.new
    assert_that processor.process("Bonjour\r\nle monde\r\n"), is("Bonjour\nle monde\n")
  end
end
