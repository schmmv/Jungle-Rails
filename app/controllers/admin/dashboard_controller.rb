class Admin::DashboardController < ApplicationController
  def show
    @productsCount = Product.count
    @categories = Category.all
    @categoriesCount = Category.count
  end
end
