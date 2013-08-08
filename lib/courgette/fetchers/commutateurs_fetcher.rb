module Courgette
  module Fetchers
    class CommutateursFetcher < Fetcher
      VENDORS = {
        'cisco'     => Commutateurs::Cisco,
        'fortigate' => Commutateurs::Fortigate,
        'h3c'       => Commutateurs::H3c,
        'juniper'   => Commutateurs::Juniper
      }

      def initialize(ip, details)
        @ip = ip
        @klass = VENDORS[details['vendor']]
        @credentials = Commutateurs::Credentials.new(details['login'], details['password'], details['enable'])
      end

      def self.responsible_of(vendor)
        ["cisco", "h3c", "juniper", "fortigate"].include? vendor
      end

      def fetch
        device = @klass.new(@ip, @credentials, false)

        device.connect
        device.enable

        device.configuration
      end
    end
  end
end
