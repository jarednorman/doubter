require 'test_helper'

module Doubter
  class RouterTest < Minitest::Test
    HomeController = Class.new
    ProductsController = Class.new
    LineItemsController = Class.new
    UsersController = Class.new
    SessionsController = Class.new

    class MyRouter < Router
      get "/",
        controller: HomeController,
        action: :index
      get %r(/product/(?<id>.*)),
        controller: ProductsController,
        action: :show
      post %r(/order/(?<order_id>.*)/line_items),
        controller: LineItemsController,
        action: :create
      put %r(/order/(?<order_id>.*)/line_items/(?<id>.*)),
        controller: LineItemsController,
        action: :update
      patch %r(/user),
        controller: UsersController,
        action: :update
      delete %r(/logout),
        controller: SessionsController,
        action: :destroy
    end

    def test_get_without_params
      router = MyRouter.new path: "/", method: 'GET'
      assert_equal :index, router.action
      assert_equal HomeController, router.controller
      assert_equal Hash.new, router.route_params
    end

    def test_get_with_params
      router = MyRouter.new path: "/product/hat", method: 'GET'
      assert_equal :show, router.action
      assert_equal ProductsController, router.controller
      assert_equal({ "id" => "hat" }, router.route_params)
    end

    def test_post_with_params
      router = MyRouter.new path: "/order/123/line_items", method: 'POST'
      assert_equal :create, router.action
      assert_equal LineItemsController, router.controller
      assert_equal({ "order_id" => "123" }, router.route_params)
    end

    def test_put_with_multiple_params
      router = MyRouter.new path: "/order/123/line_items/10", method: 'PUT'
      assert_equal :update, router.action
      assert_equal LineItemsController, router.controller
      assert_equal({ "order_id" => "123", "id" => "10" }, router.route_params)
    end

    def test_patch_without_params
      router = MyRouter.new path: "/user", method: 'PATCH'
      assert_equal :update, router.action
      assert_equal UsersController, router.controller
      assert_equal Hash.new, router.route_params
    end

    def test_delete_without_params
      router = MyRouter.new path: "/logout", method: 'DELETE'
      assert_equal :destroy, router.action
      assert_equal SessionsController, router.controller
      assert_equal Hash.new, router.route_params
    end

    def test_no_route
      assert_raises Router::RouteNotMatched do
        MyRouter.new path: "/black-sabbath", method: 'GET'
      end
    end
  end
end
