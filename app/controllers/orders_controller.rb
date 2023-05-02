class OrdersController < ApplicationController
  before_action :find_order, only: [:show, :edit, :update, :destroy]
  before_action :find_product, only: [:new, :create, :update]
  before_action :check_admin, only: [:new, :create, :edit, :update, :destroy]

  def index
    @orders = Order.all
  end

  def show; end

  def new
    @order = Order.new
  end

  def create
    @order = @product.orders.new(order_params)
    if @order.save
      redirect_to product_order_path(@product, @order)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @order.update(order_params)
      redirect_to product_order_path(@product, @order)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_path, status: :see_other
  end

  private
  def order_params
    params.require(:order).permit(:quantity, :order_status)
  end

  def find_order
    @order = Order.find(params[:id])
  end

  def find_product
    @product = Product.find(params[:product_id])
  end

  def check_admin
    unless current_user.Admin?
      redirect_to products_path, alert: "You do not have permission to perform this action."
    end
  end
end
