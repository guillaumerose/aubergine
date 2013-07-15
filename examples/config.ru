require 'aubergine'

Aubergine.register([
  {
    name: 'remote1',
    key: 'presharedkey',
    devices: [
      { ip: '192.168.0.1', vendor: 'hp', login: 'admin', password: 'admin' }
    ]
  }
])

Aubergine.repository = "/tmp/aubergine"

run Aubergine::Server
