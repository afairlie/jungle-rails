class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['HTTP_AUTH_NAME'], password: ENV['HTTP_AUTH_PASSWORD']
  
  def show
    @products = Product.count
    p @products

    @categories = Category.count
    p @categories
  end
end
