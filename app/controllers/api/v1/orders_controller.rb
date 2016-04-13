class Api::V1::OrdersController < ApplicationController
  before_action :user_authentication!

  respond_to :json

  def index
    respond_with current_user.orders
  end

  def show
    respond_with current_user.orders.find_by_id(params[:id])
  end

  def create
    order = current_user.orders.build order_params
    if order.save
      SendMailConfirm.perform_async order.id
      render json: order, status: 201, location: [:api, :v1, current_user, order]
    else
      render json: order.errors, status: 422
    end
  end

  private
  def order_params
    params.require(:order).permit product_ids: []
  end
end