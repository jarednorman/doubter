require "doubter/route"

module Doubter
  class RouteNotMatched < StandardError
  end

  class Router
    class << self
      %w(GET POST PUT PATCH DELETE).each do |method|
        define_method(method.downcase) do |path, controller:, action:|
          routes << Route.new(
            path: path,
            method: method,
            controller: controller,
            action: action
          )
        end
      end

      def routes
        @routes ||= []
      end
    end

    def initialize(path:, method:)
      routes.each do |route|
        if match = route.match(path: path, method: method)
          @route_match = match
          break
        end
      end
      raise RouteNotMatched unless route_match
    end

    def action
      route_match.action
    end

    def controller
      route_match.controller
    end

    def route_params
      route_match.params
    end

    private

    attr_reader :route_match

    def routes
      self.class.routes
    end
  end
end
