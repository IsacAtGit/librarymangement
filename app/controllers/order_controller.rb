class OrderController < ApplicationController
before_action :check_stock_avalilable, only: :createorder

  def create
    order = Order.new(get_params)
    @book = Book.find(params[:book_id])
    @user = User.find(params[:user_id])
    if @user.orders.where(book: @book, return_date: nil).exists?
      render json: { message: "Book already purchased by this user", status: "400" }, status: :bad_request
      return
    else
       if order.save
       book=Book.find(order.book_id) #book id in boook table
       stock=book.stock
       stock = stock- 1
       book.stock=stock
       book.save
       render json: {message:"order successfull",status:"200",order: order},status: :ok
       else
       render json:{message:"unable to save order",status:"400"}, status: :bad_request
       end
    end
  end

  def update
    begin
      order_obj = Order.find(params[:id])
      if order_obj.return_date.nil?
         order_obj.return_date=Date.today
         book=Book.find(order_obj.book_id)
         if order_obj.save
          stock=book.stock

          stock = stock+1
          book.stock=stock
          book.save
          render json: {message:"Book return successfull",status:"200",order: order_obj},status: :ok
          else
          render json:{message:"unable to return book",status:"400"}, status: :bad_request
          end
      else
      render json:{message:"Book already retuned",status:"400"}, status: :bad_request
      end
    rescue ActiveRecord::RecordNotFound
      render json:{message:"unable to get the order #{params[:id]}"}, status: :bad_request
    end
  end

  def show
    begin
    @user = User.where(id:params[:user_id])
    if @user.books.empty?
      render json:{message:"Nothing to show here"}
    else
      render json:{message:"user orders",user_order:@user.books}
    end
    rescue ActiveRecord::RecordNotFound
      render json:{message:"user id not exists"}
    end
  end

  private
  def get_params
    params.require(:order).permit(:user_id,:book_id)
  end


  private
  def check_stock_avalilable
    book = Book.find(params[:book_id])
    stock=book.stock
    puts "#{stock}"
    puts "--------------------"
    if stock >5 || stock <=0
     render json: {error:"Stock not available"},status: :not_found
    end
  end
end
