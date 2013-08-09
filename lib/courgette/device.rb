module Courgette
  class Device
    attr_reader :ip, :vendor

    def initialize(details)
      @ip = details['ip']
      @vendor = details['vendor']
      @details = details
    end

    def fetch(debug = false)
      chain = Chain.all.find { |chain| chain.responsible_of(@vendor) }
      chain ? chain.apply(@ip, @details) : raise("Vendor not found")
    end

    def to_s
      "#{ip}/#{vendor}"
    end
  end
end
