module SakurraForm
  class Resource
    class Base
      include SakurraForm::Helper

      attr_accessor :name, :resource_id, :configuration, :cached_state, :remote_state
      def initialize(name, enable_remote = false)
        type = self.class.to_s.split('::').last.downcase
        @name = name
        @resource_id = resolve_id_by_name(type, name)
        @configuration = SakurraForm::Plans[type.to_sym].select {|a| a.name == name}
        @cached_state = @resource_id  ? collect_cached_state(type) : nil
        enable_remote = false unless @cached_state
        @remote_state = enable_remote ? collect_remote_state : nil
      end

      def collect_cached_state(type)
        state_path = "state/#{type}/#{@resource_id}.yml"
        return {} unless File.exists?(state_path)
        YAML.load(File.read(state_path))
      end

      def collect_remote_state
        # Override It
      end

      def flush_cached_state(type)
        state_path = "state/#{type}/#{@resource_id}.yml"
        return true unless File.exists?(state_path)
        File.delete(state_path)
      end
    end
  end
end
