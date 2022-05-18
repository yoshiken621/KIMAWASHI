class Like < ApplicationRecord
  # ユーザー情報と投稿情報との紐付け
  belongs_to :user
  belongs_to :event
end
