module Aubergine
  class Device < Struct.new(:ip, :vendor, :login, :password, :enable)
    def self.build(hash)
      new(hash[:ip], hash[:vendor], hash[:login], hash[:password], hash[:enable])
    end

    def to_map
      map = Hash.new
      self.members.each { |m| map[m] = self[m] if self[m] }
      map
    end

    def to_json(*a)
      to_map.to_json(*a)
    end
  end
end
