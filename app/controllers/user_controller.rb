class UserController < ApplicationController

    before_action :validate_params_presence, only: :createuser
    def create
        user = User.new(user_params)
        # user = User.new(name: 'John', email: 'john@example.com', password:"jhon2002",mobilenumber:"9876543210")
       user.is_admin=false
        # Check for duplicate entry by searching for an existing user with the same mobile number
        existing_user = User.where(mobilenumber: user.mobilenumber).or(User.where(email: user.email)).first


        if existing_user
          render json: { error: 'Mobile number or email already exists.' }, status: :unprocessable_entity
        elsif user.save
          session[:current_user] = user.id
          response = {
            message: 'User saved successfully.',
            user: user
          }
          render json: response
        else
          render json: { errors: user.errors.full_messages }, status: :bad_request
        end
    end




    def index
         user=User.all
         response={
            message:"all users list fetched successfully",
            user:user
         }
         render json: response
      end

      def makeusertoadmin
        begin
          user = User.find_by(id: params[:id])
          user.is_admin = true
          p user.is_admin

          if user.update_columns(is_admin: true)
            response = {
              message: "#{user.email} is admin now",

            }
            render json: response
          else
            response = {
              message: "Unable to make admin #{user.email}",
              errors: user.errors.full_messages
            }
            render json: response, status: :unprocessable_entity
          end
        rescue ActiveRecord::RecordNotFound
          response = {
            error: "User with id #{params[:id]} not found",
            status: "404"
          }
          render json: response, status: :not_found
        end
    end

      def delete
        begin
        user=User.find(params[:id])
        if user.destroy
        response={
            message:"user deleted"

         }
         render json: response
        else
            responcefail={
                :status=>"404"
            }
            render json: response
        end
        rescue ActiveRecord::RecordNotFound #...
        response = {
          error: "user with id #{params[:id]} not found",
          status:"404"
        }
        render json: response, status: :not_found
        end
      end

      def show
        begin
          user = User.find(params[:id])
          response = {
            message: 'user details fetched',
            user: user
          }
          render json: response
        rescue ActiveRecord::RecordNotFound
          response = {
            error: "user with id #{params[:id]} not found",
            status:"404"
          }
          render json: response, status: :not_found
        end
      end


    def edit
        begin

        user=User.find(params[:id])

        user.name=params[:name]
        user.mobilenumber=params[:mobilenumber]
        user.password=params[:password]
        user.password=params[:email]
        if user.save
            responsedone={
            message:"user updated"

         }
         render json: response
        else
            responcefail={
                :status=>"400",
                :message =>"unable to save user"
            }
            render json: response
        end
        rescue ActiveRecord::RecordNotFound
        response = {
          error: "user with id #{params[:id]} not found",
          status:"404"
        }
        render json: response, status: :not_found
        end
    end


  private

  def user_params
    params.require(:user).permit(:name, :mobilenumber, :password,:email)
  end
  private

  def validate_params_presence
    unless params[:user].present? && params[:user][:email].present? && params[:user][:name].present? && params[:user][:mobilenumber].present? && params[:user][:password].present?
      render json: { error: 'Required user parameters are missing.' }, status: :unprocessable_entity
    end
  end

end
