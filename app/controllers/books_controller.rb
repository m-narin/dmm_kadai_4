class BooksController < ApplicationController
  before_action :is_matching_created_user, only: [:edit, :update, :destroy]

  def index
    @books = Book.all
    @new_book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:book_created] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @new_book = @book
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:book_edited] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_created_user
    book = Book.find(params[:id])
    user = book.user
    if user.id != current_user.id
      redirect_to books_path
    end
  end
end
