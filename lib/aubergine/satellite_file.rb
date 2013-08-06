module Aubergine
  class SatelliteFile < Satellite
    def self.find(key)
      satellite = @@all.find { |satellite| satellite[:key] == key }
      if satellite
        new(satellite[:name], satellite[:devices].map { |device| Device.build(device) })
      else
        nil
      end
    end

    def self.all=(data)
      @@all = data
    end
  end
end
