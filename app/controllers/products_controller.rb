class ProductsController < ApplicationController
  def index
    # Code to load all products into an instance variable
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end
end
