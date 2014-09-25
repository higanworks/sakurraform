module SakurraForm
  module Helper

    def resolve_id_by_name(type, name)
      files = Dir.glob("state/#{type}/#{name}-????????-????-????-????-????????????.yml")
      return nil if files.empty?
      raise "Abort: Same name detected." if files.size > 1
      File.basename(files.first, '.yml')
    end

    def resolve_sakura_id_by_resource_id(type, resouce_id)
      state_file = "state/#{type}/#{resouce_id}.yml"
      return nil unless File.exists?(state_file)
      resource = YAML.load(File.read(state_file))
      resource[:id]
    end

    def resolve_sakura_id_by_name(type, name)
      resouce_id = resolve_id_by_name(type, name)
      return nil unless resouce_id
      resolve_sakura_id_by_resource_id(type, resouce_id)
    end

    def fog_client(service)
      # Pending
    end

    def name_plus_uuid(name)
      [name, UUID.generate].join('-')
    end
  end
end
