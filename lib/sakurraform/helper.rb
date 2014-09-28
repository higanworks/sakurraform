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

    def resolve_sakura_id_by_combined(c_resource)
      type, name = split_combined_resource(c_resource)
      sakura_id = resolve_sakura_id_by_name(type, name)
      raise "Abort: Depend resource #{c_resource} not created." unless sakura_id
      sakura_id
    end

    def split_combined_resource(c_resource)
      type, name = c_resource.split('[').first, c_resource.match(/\[([\w]+)\]/)[1]
      [ type, name ]
    end

    def fog_client(service)
      # Pending
    end

    def name_plus_uuid(name)
      [name, UUID.generate].join('-')
    end

    def get_offset_address(ip, offset)
      dec_ip = IPAddress(ip).to_i + offset
      IPAddr.new(dec_ip, Socket::AF_INET).to_s
    end
  end
end
