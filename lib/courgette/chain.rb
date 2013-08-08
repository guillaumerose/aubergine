module Courgette
  class Chain
    def initialize(fetcher, processors)
      @fetcher = fetcher
      @processors = processors
    end

    def self.of(fetcher, *processors)
      new(fetcher, processors)
    end

    def apply(ip, hash)
      raw = @fetcher.new(ip, hash).fetch
      @processors.map(&:new).inject(raw) { |acc, p| acc = p.process(acc) }
    end

    def responsible_of(vendor)
      @fetcher.responsible_of(vendor)
    end

    def self.all
      [
        Chain.of(Fetchers::CommutateursFetcher, Processors::DefaultProcessor),
        Chain.of(Fetchers::HpFetcher, Processors::DefaultProcessor)
      ]
    end
  end
end
