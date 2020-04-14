class BooksController < ApplicationController
  # ログインユーザーのみ下記アクション可能
 before_action :authenticate_user!, only: [:index, :show, :edit, :update]
 before_action :correct_user, only: [:edit, :update]


  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all
    @user = current_user
  end



  def create
  	   @book = Book.new(book_params)
       @book.user_id = current_user.id
    if @book.save
       flash[:notice] = "successfully"
  	   redirect_to book_path(@book.id)
    else
       @user = User.find(current_user.id)
       @books = Book.all
       @users = User.all
       render action: :index
    end
  end




  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    @book_new = Book.new
  end




  def edit
    @book = Book.find(params[:id])
  end


  def update
       @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "successfully"
       redirect_to book_path(@book.id)
    else
       render :edit
    end
  end



  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to "/books"
  end

private

  def book_params
	  params.require(:book).permit(:title, :body)
  end

  def correct_user
       @book = Book.find(params[:id])
    if current_user.id != @book.user_id
       redirect_to books_path
    end
  end


end
