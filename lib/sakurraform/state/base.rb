module SakurraForm
    module State
    class Base
      attr_accessor :local, :remote
      def initialize
        @local  = collect_local(:base)
        @remote = {}
      end

      def collect_local(service)
        plan = "plan/#{service.to_s}.yml"
        return {} unless File.exists?(plan)
        YAML.load(File.read(plan))
      end
    end
  end
end
