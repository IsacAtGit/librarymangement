class AuthorController < ApplicationController
    before_action :validate_params_presence, only: :create
    before_action :check_admin_access, only: [:create, :delete,:edit]
      def create
        author = Author.new(author_params)
        if author.save
          response = {
            message: 'author saved successfully.',
            author: author
          }
          render json: response
        else
          render json: { errors: author.errors.full_messages }, status: :bad_request
        end
      end


      def index
         author=Author.all
         response={
            message:"all authors list fetched successfully",
            author:author
         }
         render json: response
      end


      def delete
        begin
        author=Author.find(params[:id])
        if author.destroy
        response={
            message:"author deleted"
         }
         render json: response
        else
            responcefail={
                :status=>"404",
                :message=>"unable to delete author"
            }
            render json: response

        end
        rescue ActiveRecord::RecordNotFound
            response = {
            error: "Author with id #{params[:id]} not found",
            status: "404"
          }
          render json: response, status: :not_found
        end

      end

      def show
        begin
          author = Author.find(params[:id])
          response = {
            message: 'Author details fetched',
            author: author
          }
          render json: response
        rescue ActiveRecord::RecordNotFound
          response = {
            error: "Author with id #{params[:id]} not found",
            status: "404"
          }
          render json: response, status: :not_found
        end
      end


      def edit
        begin
          author=Author.find(params[:id])
        #author=author.find(params[:id])

          author.first_name=params[:first_name]
          author.last_name=params[:last_name]
           if author.save
            responsedone={
            message:"author updated"
            }
            render json: response, status: :not_found
            else
             responcefail={
                :status=>"Unable to save"
               }
              render json: response
            end
        rescue ActiveRecord::RecordNotFound
          response = {
            error: "Author with id #{params[:id]} not found",
            status:"404"
          }
          render json: response, status: :not_found
        end

      end


  private

  def author_params
    params.require(:author).permit(:first_name, :last_name)
  end
  private

  def validate_params_presence
    unless params[:author].present? && params[:author][:first_name].present? && params[:author][:last_name].present?
      render json: { error: 'Required author parameters are missing.' }, status: :unprocessable_entity
    end
  end
end
