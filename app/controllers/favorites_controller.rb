class FavoritesController < ApplicationController

def create
  book = Book.find(params[:book_id])
  favorite = Favorite.new(book_id: book.id, user_id: current_user.id)
  # favorite = current_user.favorites.new(post_image_id: post_image.id)
  # どちらも同じ処理になる

  favorite.save
  redirect_to books_path
  # indexの中から指定のbookを探してそれにいいねをつける必要がある。ルーティングでネストしているからbook_idも拾えている。
end

def destroy
  book = Book.find(params[:book_id])
  favorite = current_user.favorites.find_by(book_id: book.id)
  favorite.destroy
  redirect_to books_path
end

end
