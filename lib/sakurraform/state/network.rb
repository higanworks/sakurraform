module SakurraForm
  module State
    class Network < SakurraForm::State::Base
      def initialize
        @local  = collect_local(:network)
        @remote = {}
      end
    end
  end
end
