module Courgette
  module Fetchers
    class HpFetcher < Fetcher
      def initialize(ip, details)
        @ip = ip
        @user = details['login']
        @password = details['password']
      end

      def self.responsible_of(vendor)
        "hp" == vendor
      end

      def fetch     
        begin
        data = ""
        Net::SFTP.start(@ip, @user, :password => @password) do |sftp|
          data = sftp.download!("/cfg/running-config")
        end
        data
        rescue IOError => e
        data
        end
      end
    end
  end
end
