module Doubter
  class Route
    RouteMatch = Struct.new(:controller, :action, :params)

    attr_reader :controller,
                :path,
                :method,
                :action

    def initialize(path:, method:, controller:, action:)
      @path = path
      @method = method
      @controller = controller
      @action = action
    end

    def match(path:, method:)
      return false unless method == self.method
      return false unless matches_path? path
      RouteMatch.new(controller, action, extract_params(path))
    end

    private

    def matches_path?(path)
      if self.path.is_a? Regexp
        self.path.match(path)
      else
        path == self.path
      end
    end

    def extract_params(path)
      return {} unless self.path.is_a? Regexp

      match = self.path.match path
      Hash[match.names.zip match.captures]
    end
  end
end
