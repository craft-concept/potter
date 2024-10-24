module Potter
  class Endpoints
    def self.resources(name, only: nil)
      @resources ||= []
      @resources << {name:, only:}
    end
  end
end
