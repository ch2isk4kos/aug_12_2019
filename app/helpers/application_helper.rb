module ApplicationHelper

    # checks for the current user
    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
        # binding.pry
    end

    # checks if current user is logged in
    def logged_in?
        !!current_user
    end
    
end
