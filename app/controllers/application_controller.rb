class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
    set_user
    render 'static_pages/home'
  end

  private

  def set_user
    @user = current_user
  end
end