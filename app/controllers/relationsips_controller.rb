class RelationsipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to request.referer
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to  request.referer
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end
  # 特定のユーザーがフォローしているユーザーの一覧を表示するためのアクション

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
  # 特定のユーザーがフォローされているユーザーの一覧を表示するためのアクション

end
