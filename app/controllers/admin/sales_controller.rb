class Admin::SalesController < ApplicationController
  http_basic_authenticate_with name: ENV['AUTHENTICATION_USERNAME'], password: ENV['AUTHENTICATION_PASSWORD']

  def index
    @sales = Sale.all
  end

  def new
    @admin_sale = Sale.new
  end

  def create
    @admin_sale = Sale.new(sale_params)
  
    if @admin_sale.save
      redirect_to [:admin, :sales], notice: 'Sale Created!'
    else
      render :new
    end
  end

  def sale_params
    params.require(:sale).permit(
      :name,
      :percent_off,
      :starts_on,
      :ends_on
    )
  end
end

