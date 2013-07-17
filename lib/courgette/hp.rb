module Courgette
  class HP
    def initialize(ip, credentials, verbose = false)
      @ip = ip
      @credentials = credentials
    end

    def enable
    end

    def connect
    end

    def configuration
      begin
        data = ""
        Net::SFTP.start(@ip, @credentials.user, :password => @credentials.password) do |sftp|
          data = sftp.download!("/cfg/running-config")
        end
        data
      rescue IOError => e
        data
      end
    end

    def save
    end

    def disconnect
    end
  end
end
