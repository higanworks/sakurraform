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
      update_chain
    end
  end
end
