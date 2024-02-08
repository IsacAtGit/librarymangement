class UserController < ApplicationController
    before_action :validate_params_presence, only: :createuser
    def createuser
        user = User.new(user_params)

        # Check for duplicate entry by searching for an existing user with the same mobile number
        existing_user = User.find_by(mobilenumber: user.mobilenumber)

        if existing_user
          render json: { error: 'Mobile number already exists.' }, status: :unprocessable_entity
        elsif user.save
          response = {
            message: 'User saved successfully.',
            user: user
          }
          render json: response
        else
          render json: { errors: user.errors.full_messages }, status: :bad_request
        end
    end


      def readalluser
         user=User.all
         response={
            message:"all users list fetched successfully",
            user:user
         }
         render json: response
      end


      def deleteuser
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

      def readuser
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


    def edituser
        begin

        user=User.find(params[:id])

        user.name=params[:name]
        user.mobilenumber=params[:mobilenumber]
        user.password=params[:password]
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
    params.require(:user).permit(:name, :mobilenumber, :password,:role)
  end
  private

  def validate_params_presence
    unless params[:user].present? && params[:user][:name].present? && params[:user][:mobilenumber].present? && params[:user][:password].present?
      render json: { error: 'Required user parameters are missing.' }, status: :unprocessable_entity
    end
  end
end
