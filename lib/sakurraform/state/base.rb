module SakurraForm
    module State
    class Base
      attr_accessor :local, :remote
      def initialize
        @local  = collect_local(:base)
        @remote = collect_remote(:base)
      end

      def collect_local(service)
        plan = "plan/#{service.to_s}.yml"
        return {} unless File.exists?(plan)
        resources = YAML.load(File.read(plan))
        has_dup_name?(resources)
        resources
      end

      def collect_remote(service)
        ## Please Override
      end

      def has_dup_name?(resources)
        ar = []
        resources.map{|res| ar << res['name']}
        raise "Your plan has duplicate resource name." if ar.size != ar.uniq.size
        true
      end
    end
  end
end
