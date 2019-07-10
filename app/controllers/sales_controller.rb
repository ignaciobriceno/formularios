class SalesController < ApplicationController
  def index
  	@sales = Sale.all
  end

  def new
  	@sale = Sale.new
  end

  def create
  	@sale = Sale.new(sale_params)
  	ponderador = 1 - @sale.discount.to_f/100
  	if @sale.tax == 1
  		@sale.update_attribute :total, 0.81*@sale.value*ponderador
  	else
  		@sale.update_attribute :total, @sale.value*ponderador
  	end
  	@sale.save
  	redirect_to sales_done_url
  end

  def done
  	@sales = Sale.all
  end

  private
  def sale_params
  	params.require(:sale).permit(:cod, :detail, :category, :value, :discount, :tax, :total)
  end
end
