class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    if @books.any?
      show_book = @books[0]
      @show_user = User.find(show_book.user_id)
      @book = Book.new
    else
      @show_user = User.find(params[:id])
      @book = Book.new
    end
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    # ensure_correct_user
    @user = User.find(params[:id])
  end

  def update
    # ensure_correct_user
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end