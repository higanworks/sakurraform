module SakurraForm
  class CLI < Thor
    include Thor::Actions

    def self.source_root
      File.expand_path("../../", __FILE__)
    end

    desc 'status', "show status"
    def status
      ## Prepare Network
      col_network = SakurraForm::Collection.new('network')
      col_network.collection_resources(true)
      col_network.resources.each do |resouce|
        say(pp resouce)
      end
    end
  end
end
