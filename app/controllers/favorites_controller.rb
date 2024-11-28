class FavoritesController < ApplicationController

def create
  @book = Book.find(params[:book_id])
   # indexの中から指定のbookを探してそれにいいねをつける必要がある。ルーティングでネストしているからbook_idも拾えている。
  favorite = Favorite.new(book_id: @book.id, user_id: current_user.id)
  # favorite = current_user.favorites.new(post_image_id: post_image.id)
  # どちらも同じ処理になる

  favorite.save
  # redirect_to request.referer
  # redirectに直前のURLを取得するメソッドを使って直前の画面に遷移する。
end


def destroy
  @book = Book.find(params[:book_id])
  favorite = current_user.favorites.find_by(book_id: @book.id)
  favorite.destroy
  # redirect_to request.referer
end

end
