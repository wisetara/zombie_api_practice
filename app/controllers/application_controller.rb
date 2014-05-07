class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  #before_action :set_locale
  before_action ->{ @remote_ip = request.headers['REMOTE_ADDR'] }

  protected
  def set_locale
    I18n.locale = request.headers['Accept-Language']
  end
end

