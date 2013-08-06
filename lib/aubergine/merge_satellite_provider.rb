module Aubergine
  class MergeSatelliteProvider < SatelliteProvider
    def initialize(*providers)
      @providers = providers   
    end

    def find(key)
      @providers.each do |provider|
        satellite = provider.find(key)
        return satellite if satellite
      end
      nil
    end
  end
end
