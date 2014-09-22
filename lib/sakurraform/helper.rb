module SakurraForm
  module Helper
    def load_local
      {
        :network => SakurraForm::State::Network.new.local
      }
    end

    def update_map
      if File.exists?('state/mapping.json')
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
