module SakurraForm
  class Resource
    class Network < SakurraForm::Resource::Base
      attr_reader :mode
      def initialize(name, enable_remote = false)
        super
        if @configuration.first.has_key?(:networkmasklen)
          @mode = 'router'
        else
          @mode = 'switch'
        end
      end

      def collect_remote_state
        return {} unless @resource_id
        network = Fog::Network[:sakuracloud]
        router = network.switches.find {|n| n.name == @resource_id}
        return {} unless router
        router.all_attributes
      end
    end
  end
end
