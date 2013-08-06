module Aubergine
  class Satellite
    attr_reader :devices, :name

    def initialize(name, devices)
      @name = name
      @devices = devices
    end

    def self.find(key)
      satellite = @@all.find { |satellite| satellite[:key] == key }
      if satellite
        new(satellite[:name], satellite[:devices].map { |device| Device.build(device) })
      else
        nil
      end
    end

    def to_s
      @name
    end

    def self.all=(data)
      @@all = data
    end
  end
end
