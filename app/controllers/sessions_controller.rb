# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate!

  def new; end

  def create
    if warden.authenticate(:session)
      redirect_to root_path
    else
      redirect_to new_session_path, flash: { error: t('flash.login_fail') }
    end
  end

  def destroy
    warden.logout and redirect_to new_session_path
  end
end
