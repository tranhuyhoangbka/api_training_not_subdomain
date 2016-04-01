class Api::V1::UsersController < ApplicationController
  respond_to :json

  def index
    respond_with User.all.order(:email)
  end

  def show
    respond_with User.find_by_id(params[:id])
  end

  def create

  end

  def update

  end

  def destroy

  end
end
