module Courgette
  class Client
    include HTTParty

    def initialize(aubergine, token)
      @base = aubergine
      @headers = { headers: { 'Courgette' => token } }
    end

    def devices
      response = self.class.get("#{@base}/configuration.json", @headers)
      if response.code == 200
        response.parsed_response.map { |raw| Device.new(raw) }
      else
        raise "Configuration not found."
      end
    end

    def update_device(ip, configuration)
      response = self.class.post("#{@base}/devices/#{ip}", @headers.merge(body: { configuration: configuration }))
      if [200, 201, 202].include?(response.code)
        { 200 => "no changes", 201 => "created", 202 => "updated" }[response.code]
      else
        raise "Can't push configuration."
      end
    end
  end
end
