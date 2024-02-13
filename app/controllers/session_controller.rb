class SessionController < ApplicationController
  def login
    email= params[:email]
    password= params[:password]

    user = User.find_by(email: email)
    if user && user.authenticate(password)
       session[:current_user] = user.id
      session[:expires_at] = Time.current + 1.day
       user_id = session[:current_user]
      render json: {message:"successfully logged in","user id stored in cashe":user_id}
    else
      render json: {message:"Invalid email or password"}
    end
  end


  def logout
    session.delete("current_user")
  end
end
