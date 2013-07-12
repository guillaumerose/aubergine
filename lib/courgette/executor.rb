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
        rescue Net::SSH::AuthenticationFailed
          logger.info "#{device.ip} credentials are incorrect"
        end
      end
    end
  end
end
