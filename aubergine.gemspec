# encoding: utf-8
Gem::Specification.new do |gem|
  gem.name = "aubergine"
  gem.version = "0.1.6"
  gem.date = "2013-08-06"
  gem.authors = ["Guillaume Rose"]
  gem.email = "guillaume.rose@gmail.com"
  gem.summary = "Distributed RANCID - backup your network devices"
  gem.description = "Distributed RANCID - backup your network devices"
  gem.homepage = "http://www.github.com/guillaumerose/aubergine"

  gem.files = ["lib/aubergine/path.rb",
               "lib/aubergine/satellite.rb",
               "lib/aubergine/satellite_provider.rb",
               "lib/aubergine/file_satellite_provider.rb",
               "lib/aubergine/merge_satellite_provider.rb",
               "lib/aubergine/server.rb",
               "lib/aubergine/device.rb",
               "lib/courgette/hp.rb",
               "lib/courgette/client.rb",
               "lib/courgette/device.rb",
               "lib/courgette/executor.rb",
               "lib/aubergine.rb",
               "lib/courgette.rb"]

  gem.add_dependency('commutateurs', [">= 0.1.0"])
  gem.add_dependency('git')
  gem.add_dependency('sinatra')
  gem.add_dependency('httparty')
  gem.add_dependency('parallel')
  gem.add_dependency('net-sftp')

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'ramcrest'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'mocha'

  gem.license = 'MIT'
end
