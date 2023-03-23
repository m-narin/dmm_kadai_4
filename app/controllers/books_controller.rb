class BooksController < ApplicationController
  before_action :is_matching_created_user, only: [:edit, :update, :destroy]

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to books_path
    else
      render :new
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
  end

  def update
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
      redirect_to book_path(book.id)
    end
  end
end
