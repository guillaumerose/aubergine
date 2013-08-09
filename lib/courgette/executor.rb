module Courgette
  class Executor
    attr_reader :client, :logger

    def initialize(client, executors, logger)
      @client = client
      @executors = executors
      @logger = logger
    end

    def launch!(filter)
      Parallel.each(client.devices.select { |device| filter.call(device) }, in_threads: @executors) do |device|
        begin
        Timeout::timeout(240) { fetch_and_update(device) }
        rescue
        logger.info "#{device} execution too long (timeout)"
        end
      end
    end

    def fetch_and_update(device)
      begin
        status = client.update_device(device.ip, device.fetch)
        logger.info "#{device} #{status}"
      rescue Timeout::Error
        logger.info "#{device} is unreachable (timeout)"
      rescue Net::SSH::Disconnect
        logger.info "#{device} is unreachable (disconnect)"
      rescue Net::SSH::AuthenticationFailed
        logger.info "#{device} credentials are incorrect"
      rescue Errno::ECONNREFUSED
        logger.info "#{device} is unreachable (connection refused)"
      rescue Net::SSH::Exception => e
        logger.info "#{device} ssh error (#{e.message})"
      rescue => e
        logger.info "#{device} fatal error (#{e.class} - #{e.message})"
      end
    end
  end
end
