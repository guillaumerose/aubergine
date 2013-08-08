require File.dirname(__FILE__) + '/../test_helper'

describe Courgette::Device do
  include Ramcrest::EqualTo
  
  before do
    @chain1 = mock('chain1')
    @chain1.stubs(:responsible_of).returns(false)
    @chain1.stubs(:responsible_of).with('cisco').returns(true)

    @chain2 = mock('chain2')
    @chain2.stubs(:responsible_of).returns(false)
    @chain2.stubs(:responsible_of).with('h3c').returns(true)

    Courgette::Chain.expects(:all).returns([@chain1, @chain2])
  end

  it "find the correct chain" do
    @chain1.expects(:apply).with('127.0.0.1', { 'ip' => '127.0.0.1', 'vendor' => 'cisco', 'data' => 'data' }).returns("sample configuration")
    device = Courgette::Device.new('ip' => '127.0.0.1', 'vendor' => 'cisco', 'data' => 'data')
    assert_that device.fetch, equal_to("sample configuration")
  end
  
  it "throws an exception if the vendor is not found" do
  	device = Courgette::Device.new('ip' => '127.0.0.1', 'vendor' => 'notfound', 'data' => 'data')
  	begin
  	device.fetch
  	assert false
  	rescue RuntimeError => e
  	assert_that e.message, equal_to("Vendor not found")
  	end
  end
end
