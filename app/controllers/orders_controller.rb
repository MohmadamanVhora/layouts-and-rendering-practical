class OrdersController < ApplicationController
  before_action :find_order, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, only: [:new, :create, :edit, :update, :destroy]
  layout :theme_layout

  def index
    @orders = Order.all
  end

  def show; end

  def new
    @product = Product.find(params[:product_id])
    @order = Order.new
  end

  def create
    product = Product.find(params[:product_id])
    @order = product.orders.new(order_params)
    if @order.save
      redirect_to product_order_path(@order.product_id, @order)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(@order.product_id)
  end

  def update
    product = Product.find(params[:product_id])
    @order = product.orders.find(params[:id])
    if @order.update(order_params)
      redirect_to product_order_path(@order.product_id, @order.id)
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

  def theme_layout
    if current_user&.Admin?
      'admin'
    elsif current_user&.Merchant?
      'merchant'
    else
      'application'
    end
  end

  def check_admin
    unless current_user&.Admin?
      redirect_to products_path, alert: "You do not have permission to perform this action."
    end
  end
end
