class Admin::DashboardController < ApplicationController
  def show
    @products = Product.count
    p @products

    @categories = Category.count
    p @categories
  end
end
