module SakurraForm
  class Resource
    class Server < SakurraForm::Resource::Base
      def collect_remote_state
        return {} unless @resource_id
        compute = Fog::Compute[:sakuracloud]
        server = compute.servers.find {|n| n.name == @resource_id}
        return {} unless server
        server.all_attributes
      end
    end
  end
end
