module Courgette
  class Executor
    attr_reader :client, :logger

    def initialize(client, executors, logger)
      @client = client
      @executors = executors
      @logger = logger
    end

    def launch!
      Parallel.each(client.devices, in_threads: @executors) do |device|
        begin
          status = client.update_device(device.ip, device.fetch)
          logger.info "#{device.ip} #{status}"
        rescue Timeout::Error
          logger.info "#{device.ip} is unreachable (timeout)"
        rescue Net::SSH::Disconnect
          logger.info "#{device.ip} is unreachable (disconnect)"
        rescue Net::SSH::AuthenticationFailed
          logger.info "#{device.ip} credentials are incorrect"
        rescue Errno::ECONNREFUSED
          logger.info "#{device.ip} is unreachable (connection refused)"
        rescue
          logger.info "#{device.ip} fatal error"
        end
      end
    end
  end
end
