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
        else
          say("#{net.name} already available as #{net.resource_id}")
        end
      end

      col_networks = SakurraForm::Collection.new('network')
      col_networks.collection_resources(true)

      col_servers = SakurraForm::Collection.new('server')
      col_servers.collection_resources
      compute = Fog::Compute[:sakuracloud]
      volume  = Fog::Volume[:sakuracloud]

      col_servers.resources.each do |sv|
        unless sv.resource_id
          sv.resource_id = name_plus_uuid(sv.name)
          switch_id = resolve_sakura_id_by_combined(sv.configuration.first["switch"])
          options = sv.configuration.first.merge(
            {
              "name"   => sv.resource_id,
              "switch" => switch_id
            }
          )
          say("Create new server #{sv.name}")
          server = compute.servers.create(options)

          sv_network = (col_networks.resources.find {|n| n.cached_state[:id] == switch_id}).cached_state[:subnets].first
          sv_ipaddress = get_offset_address(sv_network["DefaultRoute"], sv.configuration.first["meta"]["network_offset"])
          subnet ={
            :ipaddress => sv_ipaddress,
            :networkmasklen => sv_network["NetworkMaskLen"],
            :defaultroute => sv_network["DefaultRoute"]
          }

          disk_id = server.disks.first['ID']
          say("Associate #{sv_ipaddress} to #{sv.name}")
          volume.associate_ip_to_disk(disk_id, subnet)
          server.boot
          create_file "state/server/#{sv.resource_id}.yml", server.all_attributes.to_yaml
        else
          say("#{sv.name} already available as #{sv.resource_id}")
        end
      end
    end
  end
end
