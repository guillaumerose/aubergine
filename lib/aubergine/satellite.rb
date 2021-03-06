module Aubergine
  class Satellite
    attr_reader :devices, :name

    def initialize(name, devices)
      @name = name
      @devices = devices
    end

    def to_s
      @name
    end

    def self.find(*args)
      @@backend.find(*args)
    end

    def self.backend=(data)
      @@backend = data
    end
  end
end
