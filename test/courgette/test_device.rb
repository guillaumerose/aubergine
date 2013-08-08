require File.dirname(__FILE__) + '/../test_helper'

describe Courgette::Device do
  include Ramcrest::EqualTo
  
  it "can retrieve the configuration" do
  	@credentials = mock('credentials')
  	@cisco = mock('device')
  	
  	Commutateurs::Credentials.stubs(:new).with('login', 'password', 'enable').returns(@credentials)
  	Commutateurs::Cisco.stubs(:new).with('127.0.0.1', @credentials, false).returns(@cisco)

  	@cisco.expects(:connect)
  	@cisco.expects(:enable)
  	@cisco.expects(:configuration).returns("Configuration")

  	device = Courgette::Device.new('127.0.0.1', 'cisco', 'login', 'password', 'enable')
  	assert_that device.fetch, equal_to("Configuration")
  end

  it "throws an exception if the vendor is not found" do
  	device = Courgette::Device.new('127.0.0.1', 'notfound', 'login', 'password', 'enable')
  	begin
  	device.fetch
  	assert false
  	rescue RuntimeError => e
  	assert_that e.message, equal_to("Vendor not found")
  	end
  end
end
