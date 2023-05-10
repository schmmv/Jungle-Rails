class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.order(id: :desc).all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Product.new(category_name)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category added!'
    else
      render :new
    end
  end
end
