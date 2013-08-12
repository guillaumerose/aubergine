# encoding: utf-8
Gem::Specification.new do |gem|
  gem.name = "aubergine"
  gem.version = "0.2.2"
  gem.date = "2013-08-12"
  gem.authors = ["Guillaume Rose"]
  gem.email = "guillaume.rose@gmail.com"
  gem.summary = "Distributed RANCID - backup your network devices"
  gem.description = "Distributed RANCID - backup your network devices"
  gem.homepage = "http://www.github.com/guillaumerose/aubergine"

  gem.files = ["lib/aubergine/device.rb",
               "lib/aubergine/server.rb",
               "lib/aubergine/satellite.rb",
               "lib/aubergine/file_satellite_provider.rb",
               "lib/aubergine/satellite_provider.rb",
               "lib/aubergine/merge_satellite_provider.rb",
               "lib/aubergine/path.rb",
               "lib/courgette/chain.rb",
               "lib/courgette/device.rb",
               "lib/courgette/client.rb",
               "lib/courgette/fetchers/hp_fetcher.rb",
               "lib/courgette/fetchers/commutateurs_fetcher.rb",
               "lib/courgette/fetchers/fetcher.rb",
               "lib/courgette/processors/default_processor.rb",
               "lib/courgette/processors/cisco_processor.rb",
               "lib/courgette/processors/processor.rb",
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
