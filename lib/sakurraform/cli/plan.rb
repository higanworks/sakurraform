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
      template('templates/network.tt', "plan/network.yml")
    end

    desc 'apply', ''
    def apply
      run_state = SakurraForm::RunState.new

      network = Fog::Network::SakuraCloud.new
      run_state.mapping['network'].each_pair do |name, id|
        network.routers.create(:name => id, :networkmasklen => 28)
      end
    end
  end
end
