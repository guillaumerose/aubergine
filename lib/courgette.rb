require 'logger'
require 'timeout'

require 'httparty'
require 'json'

require 'commutateurs'
require 'parallel'

require 'net/sftp'

require_relative './courgette/fetchers/fetcher.rb'
require_relative './courgette/fetchers/commutateurs_fetcher.rb'
require_relative './courgette/fetchers/hp_fetcher.rb'
require_relative './courgette/processors/processor.rb'
require_relative './courgette/processors/default_processor.rb'
require_relative './courgette/chain.rb'
require_relative './courgette/device.rb'
require_relative './courgette/client.rb'
require_relative './courgette/executor.rb'

module Courgette
  def self.run!(aubergine, token, executors = 4, logger = Logger.new(STDOUT), filter = Proc.new { |device| true })
    Executor.new(Client.new(aubergine, token), executors, logger).launch!(filter)
  end
end
