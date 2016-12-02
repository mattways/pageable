class ProductsController < ApplicationController

  def index
    number = (params[:page] || 1)
    @products = Product.page(number, length: 1)
  end

end
