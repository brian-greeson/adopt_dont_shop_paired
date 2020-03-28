class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :favorite

  def favorite
    @favorite ||= Favorite.new(session[:favorite])
  end
end
