aubergine
=========

Distributed RANCID - backup your network devices


Architecture
------------

Aubergine is a web-server that provides network devices details to satellites. They send back device configurations to the server.
For each configuration received, aubergine creates a commit (with git).

![Schema](https://github.com/guillaumerose/aubergine/blob/master/architecture.png?raw=true)

Configuration
-------------

Server configuration

```ruby
Aubergine.register([
  {
    name: 'remote1',
    key: 'presharedkey',
    devices: [
      { ip: '192.168.0.1', vendor: 'hp', login: 'admin', password: 'admin' }
    ]
  }
])
Aubergine.run!("/path/gitrepo/aubergine")
```

Client configuration

```ruby
token = "presharedkey"
aubergine = "http://127.0.0.1:4567"
Courgette.run!(aubergine, token)
```
