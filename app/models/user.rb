class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # RelationshipモデルはスペルミスでRelationsipになってしまっている

  has_many :active_relationships, class_name: "Relationsip", foreign_key: "follower_id", dependent: :destroy
  # has_manyの後ろに架空のわかりやすい名前のテーブルを記述、 class_nameで既存のRelationshipモデルのfollowe_idと関連していることを記述する。
 
  has_many :followings, through: :active_relationships, source: :followed
  # has_manyの後ろに架空のわかりやすい名前のテーブルを記述、throughで上で定義したactive_relationshipsを通って関連付けすることを定義。
  # その際にsourceでactive_relationshipsに関連しているRelationshipモデルで定義したfollowedを参照していることを記述。
  
  # ここまででフォローの関連付けが完了。
  # -----------------------------------------------------------------
  # ここからフォロワーの関連付け

  has_many :passive_relationships, class_name: "Relationsip", foreign_key: "followed_id", dependent: :destroy
  # has_manyの後ろに架空のわかりやすい名前のテーブルを記述、class_nameで既存のRelationshipモデルのfollowed_idと関連していることを記述する。

  has_many :followers, through: :passive_relationships, source: :follower
  # has_manyの後ろに架空のわかりやすい名前のテーブルを記述、throughで上で定義したpassivi_relationshipsを通って関連付けすることを定義。
  # その際にsourceでpassive_relationshipsに関連しているRelationshipモデルで定義したfollowerを参照していることを記述。

  # ここまででフォロワーの関連付けが完了。
  
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  # 指定したユーザーをフォローする
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end

  # 指定したユーザーのフォローを解除する
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end

  # 指定したユーザーをフォローしているかどうかを判定
  def following?(user)
    followings.include?(user)
  end
  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end


  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
end
