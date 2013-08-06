require File.dirname(__FILE__) + '/../test_helper'

class FileSatelliteProviderTest < Test::Unit::TestCase
  include Ramcrest::HasAttribute
  include Ramcrest::IncludesExactly
  include Ramcrest::EqualTo

  include Aubergine

  def setup
    @provider = FileSatelliteProvider.new([
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
  
  def test_find_devices
    satellite = @provider.find("presharedkey")
    assert_that satellite, has_attribute(:name, equal_to("remote1"))
    assert_that satellite, has_attribute(:devices, includes_exactly(has_attribute(:ip, equal_to("192.168.0.1"))))
  end

  def test_json
    satellite = @provider.find("anotherkey")
    assert_that satellite.devices.to_json, equal_to('[{"ip":"192.168.0.2","vendor":"hp","login":"admin","password":"admin"},{"ip":"192.168.0.3","vendor":"hp","login":"admin","password":"admin"}]')
  end
end
