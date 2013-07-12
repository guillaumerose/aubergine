require 'logger'

require 'httparty'
require 'json'

require 'commutateurs'
require 'parallel'

require_relative './courgette/device.rb'
require_relative './courgette/client.rb'
require_relative './courgette/executor.rb'

module Courgette
  def self.run!(aubergine, token, executors = 4, logger = Logger.new(STDOUT))
    Executor.new(Client.new(aubergine, token), executors, logger).launch!
  end
end
