# encoding: utf-8
Gem::Specification.new do |gem|
  gem.name = "aubergine"
  gem.version = "0.0.2"
  gem.date = "2013-07-15"
  gem.authors = ["Guillaume Rose"]
  gem.email = "guillaume.rose@gmail.com"
  gem.summary = "Distributed RANCID - backup your network devices"
  gem.description = "Distributed RANCID - backup your network devices"
  gem.homepage = "http://www.github.com/guillaumerose/aubergine"

  gem.files = ["lib/aubergine/path.rb",
               "lib/aubergine/satellite.rb",
               "lib/aubergine/server.rb",
               "lib/courgette/client.rb",
               "lib/courgette/device.rb",
               "lib/courgette/executor.rb",
               "lib/aubergine.rb",
               "lib/courgette.rb"]

  gem.add_dependency('commutateurs')
  gem.add_dependency('git')
  gem.add_dependency('sinatra')
  gem.add_dependency('httparty')
  gem.add_dependency('parallel')

  gem.license = 'MIT'
end