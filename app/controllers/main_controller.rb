class MainController < ApplicationController
  def login
  end

  def create
    # login = cho , password = dae
    a = User.where(login: params[:login]).first
    if a && a.authenticate(params[:password])
      redirect_to students_path
      session[:login] = true
    else
      redirect_to main_login_path, notice: 'login or password incorrect'
    end
  end

  def destroy
    reset_session
  end

end
