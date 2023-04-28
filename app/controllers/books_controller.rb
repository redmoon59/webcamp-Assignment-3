class BooksController < ApplicationController
before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice]="You have created book successfully."
      redirect_to book_path(@book)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @newbook = Book.new
  end

  def edit
    @book =Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]="Book was successfully updated."
       redirect_to book_path(@book.id)
    else
       render :edit
    end 
  end

  def destroy
   @book = Book.find(params[:id])
   if @book.destroy
      flash[:notice]="Book was successfully destroyed."
      redirect_to books_path
   else
     render :index
   end
  end

private

 def book_params
  params.require(:book).permit(:title, :body, :user_id)
 end
 
 def user_params
  params.require(:user).permit(:name, :profile_image, :introduction)
 end
  
 def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
    redirect_to books_path
    end
 end
  
end
