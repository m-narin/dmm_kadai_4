class BookCommentsController < ApplicationController
  before_action :is_matching_created_user, only: [:destroy]

  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    if @book_comment.save
      flash[:book_comment_created] = "You have created book_comment successfully."
      redirect_to book_path(@book.id)
    else
      @book = Book.find(params[:book_id])
      @new_book = Book.new
      render template: "books/show"
    end
  end

  def destroy
    book_comment = BookComment.find(params[:id])
    book_comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

  def is_matching_created_user
    book_comment = BookComment.find(params[:id])
    user = book_comment.user
    if user.id != current_user.id
      redirect_back(fallback_location: root_path)
    end
  end
end
