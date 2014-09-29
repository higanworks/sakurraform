module SakurraForm
  class CLI < Thor
    include Thor::Actions
    include SakurraForm::Helper

    def self.source_root
      File.expand_path("../../", __FILE__)
    end

    desc 'status', "show status"
    def status
      ## Showdown Network
      col_network = SakurraForm::Collection.new('network')
      col_network.collection_resources(true)
      Formatador.display_line('[green]Nework resources[/]')
      Formatador.display_table(build_state_network(col_network), [:name, :sakurraform_name, :sakura_id, :subnet, :gateway])
      say()

      ## Showdown Server
      col_server = SakurraForm::Collection.new('server')
      col_server.collection_resources(true)
      Formatador.display_line('[green]Server resources[/]')
      Formatador.display_table(build_state_server(col_server), [:name, :sakurraform_name, :sakura_id, :ipaddress, :status, :last_state_changed])
    end

  end
end
