module SakurraForm
  class Plan < Thor
    include Thor::Actions
    include SakurraForm::Helper

    def self.source_root
      File.expand_path("../../", __FILE__)
    end

    desc 'generate', 'Generate template'
    def generate
      empty_directory('state')
      empty_directory('state/network')
      empty_directory('state/server')
      template('templates/network.tt', "plan/network.yml")
      copy_file('templates/server.tt', "plan/server.yml")
    end

    desc 'apply', 'Apply plan'
    def apply
      ## Prepare Network
      col_networks = SakurraForm::Collection.new('network')
      col_networks.collection_resources

      network = Fog::Network[:sakuracloud]
      col_networks.resources.each do |net|
        unless net.resource_id
          net.resource_id = name_plus_uuid(net.name)
          options = net.configuration.first.merge({'name' => net.resource_id})
          say("Create new #{net.mode} #{net.name}")
          case net.mode
          when 'router'
            router = network.routers.create(options)
            switch = network.switches.find {|s| s.id == router.id}
          when 'switch'
            switch = network.switches.create(options)
          else
            raise "Not supported mode #{net.mode}..."
          end
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

          ## Regist Interfaces
          if sv.configuration.first["interfaces"]
            ifs = sv.configuration.first["interfaces"]
            c_switches = ifs.map do |target_sw|
              say("Creating interface connected to #{target_sw}...")
              resolve_sakura_id_by_combined(target_sw)
            end
            c_switches.map do |t_sw|
              new_if = network.interfaces.regist_onto_server(server.id)
              network.interfaces.connect_to_switch(new_if.id, t_sw)
            end
          end

          server.boot
          create_file "state/server/#{sv.resource_id}.yml", server.all_attributes.to_yaml
        else
          say("#{sv.name} already available as #{sv.resource_id}")
        end
      end
    end

    desc 'destroy', 'Destroy All Resources'
    def destroy
      ## Show resources before destroy.
      SakurraForm::CLI.new.status
      say("This operation removes all resources from Sakura no Cloud.")
      answer = ask("Are you sure (Type 'Yes')? ")
      exit unless answer == "Yes"

      ## Destroy Servers
      col_servers = SakurraForm::Collection.new('server')
      col_servers.collection_resources(true)
      compute = Fog::Compute[:sakuracloud]

      col_servers.resources.each do |sv|
        if sv.remote_state
          # puts sv.remote_state
          say("Send stop to #{sv.resource_id}")
          server = compute.servers.get(sv.remote_state[:id])
          server.stop(true)
          server.reload

          say("Waiting #{sv.resource_id} until down ... (in 15 sec)")
          3.times do
            break if server.instance["Status"] == "down"
            sleep 5
            say(".")
            server.reload
          end

          say("Deleting #{sv.resource_id} and Disks...")
          server.delete(
            true,
            server.disks.map {|d| d["ID"]}
          )
        else
          say("Server #{sv.name} not found.")
        end
        sv.flush_cached_state("server")
      end

      ## Destroy Network
      col_networks = SakurraForm::Collection.new('network')
      col_networks.collection_resources(true)
      network = Fog::Network[:sakuracloud]

      col_networks.resources.each do |net|
        if net.remote_state
          # puts net.remote_state
          if net.remote_state[:internet] && net.remote_state[:internet].any?
            say("Deleting Router #{net.resource_id} ...")
            network.delete_router(net.remote_state[:internet]["ID"])
          else
            say("Deleting Switch #{net.resource_id} ...")
            network.delete_switch(net.remote_state[:id])
          end

        else
          say("Router/Switch #{net.name} not found.")
        end
        net.flush_cached_state("network")
      end
    end
  end
end
