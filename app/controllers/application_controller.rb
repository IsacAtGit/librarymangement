class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
     before_action :check_admin_access, only: :makeusertoadmin

    private

    def check_admin_access


        # user_id = session[:current_user]
        user_id =17
        p user_id
        if user_id.nil?

            render json:{message:"session is #{user_id}"}
        else
        p user_id
        user = User.find_by(id: user_id)

        if user  && user.is_admin?

        else
         render json:{Message:"Not authorized"}
         return
        end
     end
    end
  end
