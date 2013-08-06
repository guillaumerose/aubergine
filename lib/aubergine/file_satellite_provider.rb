module Aubergine
  class FileSatelliteProvider < SatelliteProvider
    def initialize(all)
      @all = all   
    end

    def find(key)
      satellite = @all.find { |satellite| satellite[:key] == key }
      if satellite
        Satellite.new(satellite[:name], satellite[:devices].map { |device| Device.build(device) })
      else
        nil
      end
    end
  end
end
