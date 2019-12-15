class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']
  def show
    @num_products = Product.count(:id)
    @num_categories = Category.count(:id) 
  end
end
