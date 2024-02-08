class BookController < ApplicationController
  before_action :validate_params_presence, only: :createbook
  def createbook
    book = Book.new(book_params)

    # Check for duplicate entry by searching for an existing book with the same isbn
    existing_book = Book.find_by(isbn: book.isbn)

    if existing_book
      render json: { error: 'Book already exists.' }, status: :unprocessable_entity
    elsif book.save
      response = {
        message: 'book saved successfully.',
        book: book
      }
      render json: response
    else
      render json: { errors: book.errors.full_messages }, status: :bad_request
    end
  end

  

  def readallbook
    book=Book.all
    response={
       message:"all books list fetched successfully",
       book:book
    }
    render json: response
 end
  def readbook
    begin
      book = Book.find(params[:id])
      response = {
        message: 'book details fetched',
        book:book
      }
      render json: response
    rescue ActiveRecord::RecordNotFound
      response = {
        error: "book with id #{params[:id]} not found",
        status:"404"
      }
      render json: response, status: :not_found
    end
  end

  def deletebook
    begin
    book=Book.find(params[:id])
    if book.destroy
    response={
        message:"book deleted"

     }
     render json: response
    else
        responcefail={
            :status=>"404"
        }
        render json: response
    end
    rescue ActiveRecord::RecordNotFound
    response = {
      error: "book with id #{params[:id]} not found",
      status:"404"
    }
    render json: response, status: :not_found
    end
  end

  def editbook
    begin

    book=Book.find(params[:id])

    book.title=params[:title]
    book.description=params[:description]
    book.stock=params[:stock]
    book.genre=params[:genre]
    book.price=params[:price]
    book.author_id=params[:author_id]


    if book.save
        responsedone={
        message:"book updated"

     }
     render json: response
    else
        responcefail={
            :status=>"400",
            :message =>"unable to save book"
        }
        render json: response
    end
    rescue ActiveRecord::RecordNotFound
    response = {
      error: "book with id #{params[:id]} not found",
      status:"404"
    }
    render json: response, status: :not_found
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :price, :genre,:description,:stock,:author_id,:isbn)
  end
  private

  def validate_params_presence
    unless params[:book].present? && params[:book][:title].present? && params[:book][:price].present? && params[:book][:genre].present?&& params[:book][:description].present?&& params[:book][:stock].present?&& params[:book][:author_id].present?&& params[:book][:isbn].present?

      render json: { error: 'Required book parameters are missing.' }, status: :unprocessable_entity
    end
  end
end
