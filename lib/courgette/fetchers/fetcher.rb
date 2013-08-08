module Courgette
  module Fetchers
    class Fetcher
      def initialize(ip, details)
        raise "Not implemented"
      end

      def fetch
        raise "Not implemented"
      end

      def self.responsible_of(vendor)
        raise "Not implemented"
      end
    end
  end
end
