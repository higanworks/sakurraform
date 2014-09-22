module SakurraForm
  class Plan < Thor
    include Thor::Actions

    def self.source_root
      File.expand_path("../../", __FILE__)
    end

    desc 'generate', ''
    def generate
      template('templates/network.tt', "plan/network.yml")
      puts "Pending!!"
    end

    desc 'apply', ''
    def apply
      puts "Pending!!"
    end
  end
end
