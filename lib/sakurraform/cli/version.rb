module SakurraForm
  class CLI < Thor
    desc "version", "show version"
    def version
      say SakurraForm::VERSION
    end
  end
end
