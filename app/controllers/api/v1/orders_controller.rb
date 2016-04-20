class Api::V1::OrdersController < ApplicationController
  before_action :user_authentication!

  respond_to :json

  def index
    orders = current_user.orders.page(params[:page]).per params[:per_page]
    render json: orders, meta:
    {
      pagination:
      {
        per_page: params[:per_page],
        total_pages: orders.total_pages,
        total_objects: orders.total_count
      }
    }
  end

  def show
    respond_with current_user.orders.find_by_id(params[:id])
  end

  def create
    order = current_user.orders.build
    order.build_placements_with_product_ids_and_quantities params[:order][:product_ids_and_quantities]
    if order.save
      order.reload
      SendMailConfirm.perform_async order.id
      render json: order, status: 201, location: [:api, :v1, current_user, order]
    else
      render json: order.errors, status: 422
    end
  end

  private
  def order_params
    params.require(:order).permit product_ids_and_quantities: []
  end
end
