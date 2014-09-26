module SakurraForm
  class Plan < Thor
    include Thor::Actions
    include SakurraForm::Helper

    def self.source_root
      File.expand_path("../../", __FILE__)
    end

    desc 'generate', ''
    def generate
      empty_directory('state')
      empty_directory('state/network')
      empty_directory('state/server')
      template('templates/network.tt', "plan/network.yml")
      copy_file('templates/server.tt', "plan/server.yml")
    end

    desc 'apply', ''
    def apply
      ## Prepare Network
      col_networks = SakurraForm::Collection.new('network')
      col_networks.collection_resources

      network = Fog::Network[:sakuracloud]
      col_networks.resources.each do |net|
        unless net.resource_id
          net.resource_id = name_plus_uuid(net.name)
          options = net.configuration.first.merge({'name' => net.resource_id})
          say("Create new network #{net.name}")
          router = network.routers.create(options)
          switch = network.switches.find {|s| s.id == router.id}
          create_file "state/network/#{net.resource_id}.yml", switch.all_attributes.to_yaml
          col_networks.collection_resources
        else
          say("#{net.name} already available as #{net.resource_id}")
        end
      end

      col_servers = SakurraForm::Collection.new('server')
      col_servers.collection_resources
      compute = Fog::Compute[:sakuracloud]

      col_servers.resources.each do |sv|
        unless sv.resource_id
          sv.resource_id = name_plus_uuid(sv.name)
          options = sv.configuration.first.merge(
            {"switch" => resolve_sakura_id_by_combined(sv.configuration.first["switch"])}
          )
          say("Create new server #{sv.name}")
          server = compute.servers.create(options)
          create_file "state/server/#{sv.resource_id}.yml", server.all_attributes.to_yaml
          col_servers.collection_resources
        else
          say("#{sv.name} already available as #{sv.resource_id}")
        end
      end
    end
  end
end
