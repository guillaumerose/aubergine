module Aubergine
  class Path
    def self.repository
      @@repository
    end

    def self.configure(repository)
      @@repository = repository
    end

    def initialize(satellite, ip)
      @satellite = satellite
      @ip = ip
    end

    def satellite
      "#{@@repository}/#{@satellite}"
    end

    def full
      "#{@@repository}/#{@satellite}/#{@ip}"
    end

    def short
      "#{@satellite}/#{@ip}"
    end
  end
end
