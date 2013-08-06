require File.dirname(__FILE__) + '/../test_helper'

describe Aubergine::MergeSatelliteProvider do
  include Ramcrest::HasAttribute
  include Ramcrest::IncludesExactly
  include Ramcrest::EqualTo

  def setup
    @provider1 = Aubergine::FileSatelliteProvider.new([
      {
        name: 'remote1',
        key: 'presharedkey',
        devices: [
          { ip: '192.168.0.1', vendor: 'hp', login: 'admin', password: 'admin' }
        ]
      }])

    @provider2 = Aubergine::FileSatelliteProvider.new([  {
        name: 'remote2',
        key: 'anotherkey',
        devices: [
          { ip: '192.168.0.2', vendor: 'hp', login: 'admin', password: 'admin' },
          { ip: '192.168.0.3', vendor: 'hp', login: 'admin', password: 'admin' }
        ]
      }])

    @provider = Aubergine::MergeSatelliteProvider.new(@provider1, @provider2)
  end
  
  def test_find_satellite
    satellite = @provider.find("presharedkey")
    assert_that satellite, has_attribute(:name, equal_to("remote1"))

    satellite = @provider.find("anotherkey")
    assert_that satellite, has_attribute(:name, equal_to("remote2"))
  end

  def test_not_found
    satellite = @provider.find("notfound")
    assert_that satellite, equal_to(nil)
  end
end
