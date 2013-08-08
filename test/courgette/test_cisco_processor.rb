require File.dirname(__FILE__) + '/../test_helper'

describe Courgette::Processors::CiscoProcessor do
  include Ramcrest::Is

  it "hide ntp clock" do
    processor = Courgette::Processors::CiscoProcessor.new
    assert_that processor.process("!\nntp clock-period 36029161\nntp server"), is("!\n# ntp clock-period <hidden>\nntp server")
  end
end
