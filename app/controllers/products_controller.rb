class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, only: [:new, :create, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params) 
    if @product.save
      redirect_to @product
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, status: :see_other
  end

  private
  def product_params
    params.require(:product).permit(:title, :description, :price, :product_status)
  end

  def find_product
    @product = Product.find(params[:id])
  end
  
  def check_admin
    unless current_user.Admin?
      redirect_to products_path, alert: "You do not have permission to perform this action."
    end
  end
end
