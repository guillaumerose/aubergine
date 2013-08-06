require File.dirname(__FILE__) + '/../test_helper'

class ServerTest < Test::Unit::TestCase
  include Ramcrest::HasAttribute
  include Ramcrest::IncludesExactly
  include Ramcrest::EqualTo

  include Rack::Test::Methods

  def app
    Aubergine::Server
  end
  
  def setup
    Aubergine::Satellite.all = [
      {
        name: 'remote1',
        key: 'presharedkey',
        devices: [
          { ip: '192.168.0.1', vendor: 'hp', login: 'admin', password: 'admin' },
          { ip: '192.168.0.2', vendor: 'hp', login: 'admin', password: 'admin', enable: 'enable' }
        ]
      }
    ]
  end

  def test_authentication_is_required
    get '/configuration.json'
    assert_that last_response.status, equal_to(401)
  end
  
  def test_authentication_pass
    get '/configuration.json', {}, { 'HTTP_COURGETTE' => 'presharedkey' }
    assert_that last_response.status, equal_to(200)
    assert_that last_response.body, equal_to('[{"ip":"192.168.0.1","vendor":"hp","login":"admin","password":"admin"},{"ip":"192.168.0.2","vendor":"hp","login":"admin","password":"admin","enable":"enable"}]')
  end
end
