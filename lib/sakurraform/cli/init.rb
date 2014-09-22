require 'thor/group'

module SakurraForm
  class CLI  < Thor
    include Thor::Actions

    def self.source_root
      File.expand_path("../../", __FILE__)
    end

    desc 'init', 'initiaize .sakuracloud/credentials'
    def init
      empty_directory('.sakuracloud')
      @sakuracloud_api_token = ask("Sakuracloud_api_token ? ")
      @sakuracloud_api_token_secret = ask("Sakuracloud_api_token_secret ? ")
      template('templates/credentials.tt', ".sakuracloud/credentials")
    end
  end
end
