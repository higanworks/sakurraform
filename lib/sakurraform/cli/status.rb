module SakurraForm
  class Status < Thor
    include Thor::Actions

    def self.source_root
      File.expand_path("../../", __FILE__)
    end

    desc 'apply', ''
    def apply
      puts "Pending!!"
    end
  end
end
