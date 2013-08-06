require File.dirname(__FILE__) + '/../test_helper'

describe Aubergine::Server do
  include Ramcrest::HasAttribute
  include Ramcrest::IncludesExactly
  include Ramcrest::EqualTo

  include Rack::Test::Methods

  def app
    Aubergine::Server
  end
  
  before do
    Aubergine.register([
      {
        name: 'remote1',
        key: 'presharedkey',
        devices: [
          { ip: '192.168.0.1', vendor: 'hp', login: 'admin', password: 'admin' },
          { ip: '192.168.0.2', vendor: 'hp', login: 'admin', password: 'admin', enable: 'enable' }
        ]
      }
    ])
  end

  it "requires a preshared key" do
    get '/configuration.json'
    assert_that last_response.status, equal_to(401)

    get '/configuration.json', {}, { 'HTTP_COURGETTE' => 'wrong' }
    assert_that last_response.status, equal_to(401)
  end
  
  it "responds the correct json" do
    get '/configuration.json', {}, { 'HTTP_COURGETTE' => 'presharedkey' }
    assert_that last_response.status, equal_to(200)
    assert_that last_response.body, equal_to('[{"ip":"192.168.0.1","vendor":"hp","login":"admin","password":"admin"},{"ip":"192.168.0.2","vendor":"hp","login":"admin","password":"admin","enable":"enable"}]')
  end
end
