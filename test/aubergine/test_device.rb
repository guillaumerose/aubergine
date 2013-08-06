require File.dirname(__FILE__) + '/../test_helper'

describe Aubergine::Device do
  include Ramcrest::EqualTo

  it "can output json" do
    device = Aubergine::Device.build({ ip: '192.168.0.2', vendor: 'hp', login: 'admin', password: 'admin' })
    assert_that device.to_json, equal_to('{"ip":"192.168.0.2","vendor":"hp","login":"admin","password":"admin"}')
  end
end
