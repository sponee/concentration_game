class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
    set_user
    render :html => "Hello, #{@current_user.email}! Get ready to concentrate."
  end

  def set_user
    @user = current_user
  end
end
