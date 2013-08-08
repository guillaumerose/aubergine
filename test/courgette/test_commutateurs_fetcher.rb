require File.dirname(__FILE__) + '/../test_helper'

describe Courgette::Fetchers::CommutateursFetcher do
  include Ramcrest::Is

  before do
    @device = mock('device')
    @device.stubs(:connect)
    @device.stubs(:enable)
    @device.stubs(:configuration).returns("raw data")

    @credentials = mock('credentials')
    Commutateurs::Credentials.stubs(:new).with('admin', 'toto', 'titi').returns(@credentials)
  end

  it "is responsible_of cisco, h3c and juniper" do
    assert_that Courgette::Fetchers::CommutateursFetcher.responsible_of('cisco'), is(true)
    assert_that Courgette::Fetchers::CommutateursFetcher.responsible_of('h3c'), is(true)
    assert_that Courgette::Fetchers::CommutateursFetcher.responsible_of('juniper'), is(true)
    assert_that Courgette::Fetchers::CommutateursFetcher.responsible_of('fortigate'), is(true)
  end
  
  it "works with cisco" do
    Commutateurs::Cisco.expects(:new).with('192.168.0.1', @credentials, false).returns(@device)

    fetcher = Courgette::Fetchers::CommutateursFetcher.new('192.168.0.1', { 'vendor' => 'cisco', 'login' => 'admin', 'password' => 'toto', 'enable' => 'titi' })
    assert_that fetcher.fetch, is("raw data")
  end

  it "works with h3c" do
    Commutateurs::H3c.expects(:new).with('192.168.0.1', @credentials, false).returns(@device)

    fetcher = Courgette::Fetchers::CommutateursFetcher.new('192.168.0.1', { 'vendor' => 'h3c', 'login' => 'admin', 'password' => 'toto', 'enable' => 'titi' })
    assert_that fetcher.fetch, is("raw data")
  end
end
