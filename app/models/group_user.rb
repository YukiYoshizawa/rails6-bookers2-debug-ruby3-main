class GroupUser < ApplicationRecord
# これはグループとユーザーの中間tテーブルのモデル

belongs_to :user
belongs_to :group
end
