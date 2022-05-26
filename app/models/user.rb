# ユーザー情報を管理するためのモデル
class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :age_select
  belongs_to :sex_select

  # ユーザー情報が削除された時はそのユーザーに紐づく投稿も削除される。
  has_many :events, dependent: :destroy

  # ユーザー情報が削除された時はそのユーザーのいいねも削除される。
  has_many :likes, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ニックネーム、年齢、性別が入力されないと登録できない。また、ニックネームは他のユーザーが既に登録している場合は登録できない。
  validates :nickname, presence: true, uniqueness: { message: 'は既に使われています' }
  validates :age_select_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :sex_select_id, numericality: { other_than: 1, message: 'を選択してください' }

# ユーザがある投稿に既にいいねをしているかを判断する処理
  def liked_by?(event_id)
    likes.where(event_id: event_id).exists?
  end
end
