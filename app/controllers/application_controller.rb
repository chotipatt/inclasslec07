class ApplicationController < ActionController::Base
    before_action :debug

    def debug
        pp '---------------'
        pp session[:login]
        pp User.all
    end

  private 
    def login?
        return session[:login] == true
    end

    def must_login
        if login?
            return true
        else
            redirect_to main_login_path, notice: 'you must login befor access next page'
        end
    end

end
