class SessionsController < ApplicationController

    def new; end

    # login (create session)
    def create
        user = User.find_by(email: params[:user][:email])

        if user && user.authenticate(params[:user][:password])
            session[:user_id] = user.id
            redirect_to user
        else
            render :new
        end
    end

    def google_auth
        user = User.from_omniauth(auth)
        user.save
        session[:user_id] = user.id
        redirect_to user
    end

    # logout (destroy session)
    def destroy
        session.clear
        redirect_to root_path
    end

    private

    def auth
        request.env['omniauth.auth']
    end

end
