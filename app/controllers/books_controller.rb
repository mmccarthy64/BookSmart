class BooksController < ApplicationController
    before_action :authenticate_user!

    def index
        if params[:user_id] && @user = User.find_by_id(params[:user_id])
            @books = @user.books
            # binding.pry
        else
            flash[:alert] = "That user does not exist." if params[:user_id]
            @books = Book.all
        end
      end
    
      def new
        @book = Book.find_or_initialize_by(book_params)
      end
    
      def show
        if @book = Book.find_by_id(params[:id])
            @book
            # binding.pry
        else
            flash[:alert] = "Book does not exist"
            redirect_to books_path
        end
      end
    
      def edit
      end
    
      def update
      end
    
      def create
        @book = Book.find_or_initialize_by(book_params)
        if @book.save
          redirect_to books_path, notice: "#{@book.title} was created."
        else
            @error 
          render 'new'
        end
      end
    
      def destroy
        @book.destroy
        redirect_to books_path, notice: "#{@book.title} was deleted."
      end
    
      private
    
      def book_params
        params.require(:book).permit(:title, :author, :description, :page_count, :user_id)
      end
end
