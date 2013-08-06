require 'sinatra/base'
require 'json'

require 'git'

require_relative './aubergine/device.rb'
require_relative './aubergine/satellite.rb'
require_relative './aubergine/path.rb'
require_relative './aubergine/server.rb'

module Aubergine
  def self.register(data)
    Satellite.all = data
  end

  def self.repository=(repository)
    Path.configure(repository)
  end

  def self.run!
    Aubergine::Server.run!
  end
end
