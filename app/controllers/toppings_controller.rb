class ToppingsController < ApplicationController
  def index
    @toppings = Topping.all
  end
end
