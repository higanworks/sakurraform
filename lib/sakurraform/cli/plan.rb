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
      col_network = SakurraForm::Collection.new('network')
      col_network.collection_resources

      network = Fog::Network[:sakuracloud]
      col_network.resources.each do |net|
        unless net.resource_id
          net.resource_id = name_plus_uuid(net.name)
          options = net.configration.first.merge({'name' => net.resource_id})
          say("Create new network #{net.name}")
          router = network.routers.create(options)
          switch = network.switches.find {|s| s.id == router.id}
          create_file "state/network/#{net.resource_id}.yml", switch.all_attributes.to_yaml
        else
          say("#{net.name} already available as #{net.resource_id}")
        end
      end



      return
      network = Fog::Network[:sakuracloud]
      run_state.mapping['network'].each_pair do |name, id|
        if File.exists?("state/network/#{id}.yml")
          say("#{id} already available")
          next
        end
        router = network.routers.create(:name => id, :networkmasklen => 28)
        switch = network.switches.find {|s| s.id == router.id}
        create_file "state/network/#{id}.yml", switch.all_attributes.to_yaml
      end
    end
  end
end
