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

    def build_state_network(col_network)
      table_data = []
      col_network.resources.each do |resource|
        table_datum = {}
#        pp resource
        table_datum[:name] = resource.name
        table_datum[:sakurraform_name] = resource.resource_id ? resource.resource_id : 'not created'
        table_datum[:sakura_id] = resource.remote_state ? resource.remote_state[:id] : 'not created'
        table_datum[:subnet] = resource.remote_state ? resource.remote_state[:subnets].first['NetworkAddress'] + '/' + resource.remote_state[:subnets].first['NetworkMaskLen'].to_s  : 'not created'
        table_datum[:gateway] = resource.remote_state ? resource.remote_state[:subnets].first['DefaultRoute'] : 'not created'

        table_data << table_datum
      end
      table_data
    end

    def build_state_server(col_server)
      table_data = []
      col_server.resources.each do |resource|
        table_datum = {}
#        pp resource
        table_datum[:name] = resource.name
        table_datum[:sakurraform_name] = resource.resource_id ? resource.resource_id : 'not created'
        table_datum[:sakura_id] = resource.remote_state ? resource.remote_state[:id] : 'not created'
        table_datum[:status] = resource.remote_state ? resource.remote_state[:instance]['Status'] : 'not created'
        table_datum[:last_state_changed] = resource.remote_state ? resource.remote_state[:instance]['StatusChangedAt'] : 'not created'
        table_datum[:ipaddress] = resource.remote_state ? resource.remote_state[:interfaces].first['UserIPAddress'] : 'not created'

        table_data << table_datum
      end
      table_data
    end

    def init_s3
      AWS::S3.new(
        :access_key_id => Fog.credentials[:sakura_object_storage_bucket],
        :secret_access_key => Fog.credentials[:sakura_object_storage_token] ,
        :s3_endpoint => 'b.sakurastorage.jp',
        :use_ssl => true
      )
    end

  end
end
