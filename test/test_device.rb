require 'test/unit'
require 'ramcrest'

require 'aubergine'

class DeviceTest < Test::Unit::TestCase
  include Ramcrest::EqualTo

  def test_json
    device = Aubergine::Device.build({ ip: '192.168.0.2', vendor: 'hp', login: 'admin', password: 'admin' })
    assert_that device.to_json, equal_to('{"ip":"192.168.0.2","vendor":"hp","login":"admin","password":"admin"}')
  end
end
