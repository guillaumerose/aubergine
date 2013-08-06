require File.dirname(__FILE__) + '/../test_helper'

describe Aubergine::FileSatelliteProvider do
  include Ramcrest::HasAttribute
  include Ramcrest::IncludesExactly
  include Ramcrest::EqualTo

  before do
    @provider = Aubergine::FileSatelliteProvider.new([
      {
        name: 'remote1',
        key: 'presharedkey',
        devices: [
          { ip: '192.168.0.1', vendor: 'hp', login: 'admin', password: 'admin' }
        ]
      },
      {
        name: 'remote2',
        key: 'anotherkey',
        devices: [
          { ip: '192.168.0.2', vendor: 'hp', login: 'admin', password: 'admin' },
          { ip: '192.168.0.3', vendor: 'hp', login: 'admin', password: 'admin' }
        ]
      }
    ])
  end
  
  it "can find devices" do
    satellite = @provider.find("presharedkey")
    assert_that satellite, has_attribute(:name, equal_to("remote1"))
    assert_that satellite, has_attribute(:devices, includes_exactly(has_attribute(:ip, equal_to("192.168.0.1"))))
  end

  it "can output json" do
    satellite = @provider.find("anotherkey")
    assert_that satellite.devices.to_json, equal_to('[{"ip":"192.168.0.2","vendor":"hp","login":"admin","password":"admin"},{"ip":"192.168.0.3","vendor":"hp","login":"admin","password":"admin"}]')
  end
end
