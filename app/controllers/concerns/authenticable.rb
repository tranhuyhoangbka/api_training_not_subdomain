module Authenticable
  module ClassMethods

  end

  module InstanceMethods
    def current_user
      @current_user ||= User.find_by_auth_token params[:auth_token]
    end

    def user_authentication!
      return (render json: {errors: "Authenticate Failed!"}) unless current_user
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end