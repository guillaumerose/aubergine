module Aubergine
  class Server < Sinatra::Base
    configure do
      enable :logging
    end

    before do
      @satellite = SatelliteFile.find(request.env['HTTP_COURGETTE'])
      halt 401 unless @satellite
    end

    get '/configuration.json' do
      content_type 'application/json'
      @satellite.devices.to_json
    end

    post '/devices/:ip' do
      path = Path.new(@satellite, params[:ip])

      FileUtils.mkdir_p(path.satellite)
      File.open(path.full, "w") do |fd|
        fd.write(params[:configuration])
      end

      repository = Git.open(Path.repository)
      
      repository.config('user.name', 'Aubergine')
      repository.config('user.email', 'aubergine@company.com')

      shortname = path.short
      if repository.diff('HEAD', shortname).entries.length > 0
        repository.add(shortname)
        repository.commit("Updated #{params[:ip]}")
        status 202
      elsif repository.status.untracked.has_key?(shortname)
        repository.add(shortname)
        repository.commit("Created #{params[:ip]}")
        status 201
      else
        status 200
      end
    end
  end
end