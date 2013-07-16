module Courgette
  class Device
    VENDOR_CLASSES = {
      'hp' => Commutateurs::HP,
      'cisco' => Commutateurs::Cisco,
      'juniper' => Commutateurs::Juniper,
      'fortigate' => Commutateurs::Fortigate,
      'h3c' => Commutateurs::H3c
    }

    attr_reader :ip, :vendor

    def initialize(ip, vendor, login, password, enable)
      @ip = ip
      @vendor = vendor
      @login = login
      @password = password
      @enable = enable
    end

    def self.build(hash)
      new(hash['ip'], hash['vendor'], hash['login'], hash['password'], hash['enable'] || hash['password'])
    end

    def fetch(debug = false)
      credentials = Commutateurs::Credentials.new(@login, @password, @enable)

      device = VENDOR_CLASSES[vendor].new(ip, credentials, debug)
      device.connect
      device.enable

      device.configuration
    end
  end
end
