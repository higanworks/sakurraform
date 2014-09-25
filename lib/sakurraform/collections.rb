module SakurraForm
  class Collection
    attr_accessor :type, :resources
    def initialize(type)
      @type = type
      @resources = Array.new
    end

    def collection_resources(enable_remote = false)
      configration = SakurraForm::Plans[@type.to_sym]
      configration.each do |conf|
        @resources << SakurraForm::Resource.const_get(type.capitalize).new(conf[:name], enable_remote)
      end
    end
  end
end
