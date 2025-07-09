class ApplicationController < ActionController::Base
  before_action :authenticate!
  helper_method :current_user

  def warden
    request.env['warden']
  end

  def current_user
    warden.user
  end

  protected

  def authenticate!
    redirect_to new_session_path, notice: t('flash.unauthenticated') if current_user.blank?
  end
end
