module Courgette
  class Device
    VENDOR_CLASSES = {
      'hp' => Commutateurs::HP,
      'cisco' => Commutateurs::Cisco
    }

    attr_reader :ip, :vendor

    def initialize(ip, vendor, login, password)
      @ip = ip
      @vendor = vendor
      @login = login
      @password = password
    end

    def self.build(hash)
      new(hash['ip'], hash['vendor'], hash['login'], hash['password'])
    end

    def fetch
      credentials = Commutateurs::Credentials.new(@login, @password, @password)

      device = VENDOR_CLASSES[vendor].new(ip, credentials, false)
      device.connect
      device.enable

      device.configuration
    end
  end
end
