module SakurraForm
  class RunState
    include SakurraForm::Helper
    attr_accessor :mapping, :credentials
    def initialize
      ENV['FOG_RC'] = '.sakuracloud/credentials'
      @mapping = load_map
    end

  end
end

