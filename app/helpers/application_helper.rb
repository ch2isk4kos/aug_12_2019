module ApplicationHelper

    # checks for the current user
    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    # checks if current user is logged in
    def logged_in?
        !!current_user
    end

    def redirect_if_not_logged_in
      redirect_to root_path if !logged_in?
   end

end
