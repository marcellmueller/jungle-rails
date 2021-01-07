class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with name: ENV['AUTHENTICATION_USERNAME'], password: ENV['AUTHENTICATION_PASSWORD']

  def index
    @admin_category = Category.all
  end

  def new
    @admin_category = Category.new
  end

  def create
    @admin_category = Category.new(category_params)
  
    if @admin_category.save
      redirect_to [:admin, :categories], notice: 'Category Created!'
    else
      render :new
    end
  end

  def category_params
    params.require(:category).permit(
      :name
    )
  end
end
