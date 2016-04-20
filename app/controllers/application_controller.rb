class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  include Authenticable

  protected
  def pagination paged_array, per_page
    {
      pagination:
      {
        per_page: per_page,
        total_pages: paged_array.total_pages,
        total_objects: paged_array.total_count
      }
    }
  end
end
