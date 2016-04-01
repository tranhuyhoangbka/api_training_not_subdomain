class Api::V1::ProductsController < ApplicationController
  before_action :find_user, only: [:create, :update, :destroy]
  before_action :find_product, only: [:update, :destroy]
  respond_to :json

  def index
    respond_with Product.all
  end

  def show
    respond_with Product.find_by_id(params[:id])
  end

  def create
    return (render json: {error: "User not existed"}) unless @user
    product = @user.products.build product_params
    if product.save
      render json: product, status: 201, location: [:api, :v1, product]
    else
      render json: {errors: product.errors}, status: 422
    end
  end

  def update
    return (render json: {errors: "can't find user"}) unless @user
    return (render json: {errors: "can't find product"}) unless @product
    if @product.update product_params
      render json: @product, status: 200, location: [:api, :v1, @product]
    else
      render json: {errors: @product.errors}, status: 422
    end
  end

  def destroy
    return (render json: {errors: "can't find user"}) unless @user
    return (render json: {errors: "can't find product"}) unless @product
    @product.destroy
    head 204
  end

  private
  def find_user
    @user = User.find_by_id params[:user_id]
  end

  def find_product
    @product = Product.find_by_id params[:id]
  end

  def product_params
    params.require(:product).permit :title, :price, :published
  end
end
