class Relationsip < ApplicationRecord
  belongs_to :followed, class_name: "User"
  belongs_to :follower, class_name: "User"
  #belongs_toの後ろは架空のテーブルを定義していて、それはUserに関連していることを記述している。

end
