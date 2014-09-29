module SakurraForm
  class CLI  < Thor
    include Thor::Actions

    def self.source_root
      File.expand_path("../../", __FILE__)
    end

    desc 'map', 'open sakura cloud map!'
    def map
      system('open https://secure.sakura.ad.jp/cloud/#!/map/map/')
    end
  end
end
