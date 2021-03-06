require 'sinatra/base'
require 'json'

require 'git'

require_relative './aubergine/device.rb'
require_relative './aubergine/satellite.rb'
require_relative './aubergine/satellite_provider.rb'
require_relative './aubergine/file_satellite_provider.rb'
require_relative './aubergine/merge_satellite_provider.rb'
require_relative './aubergine/path.rb'
require_relative './aubergine/server.rb'

module Aubergine
  def self.register(data)
    Satellite.backend = FileSatelliteProvider.new(data)
  end

  def self.backend=(backend)
    Satellite.backend = backend
  end

  def self.repository=(repository)
    Path.configure(repository)
  end

  def self.run!
    Aubergine::Server.run!
  end
end
