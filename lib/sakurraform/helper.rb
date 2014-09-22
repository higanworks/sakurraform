module SakurraForm
  module Helper
    MAPFILE = 'state/mapping.json'

    def load_map
      return {} unless File.exists?(MAPFILE)
      JSON.parse(File.read(MAPFILE))
    end

    def load_local
      {
        :network => SakurraForm::State::Network.new.local
      }
    end

    def update_map
      if File.exists?(MAPFILE)
      else
        create_map
      end
    end

    def create_map
      resources = load_local

      mapping = {
        'network' => hashed_names(resources[:network].map {|a| a['name']})
      }
      puts JSON.pretty_generate(mapping)
      File.open(MAPFILE, 'w') do |f|
        f.puts(JSON.pretty_generate(mapping))
      end
    end

    def hashed_names(names = [])
      hash = Hash.new
      names.map do |name|
        hash[name] = name_plus_uuid(name)
      end
      hash
    end

    def name_plus_uuid(name)
      [name, UUID.generate].join('-')
    end
  end
end
