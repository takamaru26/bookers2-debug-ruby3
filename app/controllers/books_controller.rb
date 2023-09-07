class BooksController < ApplicationController
before_action :authenticate_user!
before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    #@user = User.find(params[:id])
  end

  def index
    @books = Book.all
    @book = Book.new
    
   if params[:latest]
     @books = Book.latest
   elsif params[:old]
     @books = Book.old
   elsif params[:star_count]
     @books = Book.star_count
   else
     @books = Book.all
   end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    #   @user = User.find(params[:id])
    # if @user == current_user
    #   render "edit"
    # else
    #   redirect_to user_path(current_user)
    # end
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :image, :star, :category)
  end
  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
end
