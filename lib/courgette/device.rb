module Courgette
  class Device
    VENDOR_CLASSES = {
      'hp' => Courgette::HP, # using sftp
      'cisco' => Commutateurs::Cisco,
      'juniper' => Commutateurs::Juniper,
      'fortigate' => Commutateurs::Fortigate,
      'h3c' => Commutateurs::H3c
    }

    attr_reader :ip, :vendor

    def initialize(ip, vendor, login, password, enable)
      @ip = ip
      @vendor = vendor

      @credentials = Commutateurs::Credentials.new(login, password, enable)
    end

    def self.build(hash)
      new(hash['ip'], hash['vendor'], hash['login'], hash['password'], hash['enable'])
    end

    def fetch(debug = false)
      device = vendor_class.new(ip, @credentials, debug)
      device.connect
      device.enable

      device.configuration.unpack('C*').pack('U*').gsub("\r\n", "\n")
    end

    def vendor_class
      klass = VENDOR_CLASSES[vendor]
      raise "Vendor not found" unless klass
      klass
    end
  end
end
