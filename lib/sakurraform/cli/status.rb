module SakurraForm
  class CLI < Thor
    include Thor::Actions
    include SakurraForm::Helper

    def self.source_root
      File.expand_path("../../", __FILE__)
    end

    desc 'status', "show status [--json] [--sync](to update cached_state)"
    option :sync, :type => :boolean
    option :json, :type => :boolean
    def status
      ## Showdown Network
      col_network = SakurraForm::Collection.new('network')
      col_network.collection_resources(true)
      if options[:json]
        output = Hash.new
        output["Networks"] = build_state_network(col_network)
      else
        Formatador.display_line('[green]Nework resources[/]')
        Formatador.display_table(build_state_network(col_network), [:name, :sakurraform_name, :sakura_id, :subnet, :gateway])
        say()
      end

      ## Showdown Server
      col_server = SakurraForm::Collection.new('server')
      col_server.collection_resources(true)
      if options[:json]
        output["Servers"] = build_state_server(col_server)
        say(JSON.pretty_generate(output))
      else
        Formatador.display_line('[green]Server resources[/]')
        Formatador.display_table(build_state_server(col_server), [:name, :sakurraform_name, :sakura_id, :ipaddress, :status, :last_state_changed])
      end
      if options[:sync]
        col_server.resources.each do |r|
          create_file "state/server/#{r.resource_id}.yml", r.remote_state.to_yaml
        end
      end
    end

  end
end
