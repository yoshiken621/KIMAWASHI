# 服装情報を管理するためのモデル
class Event < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :events_select
  has_one_attached :image
  belongs_to :user
  has_many :likes, dependent: :destroy

  # 服装情報を登録する際は日付、写真、その日の出来事がないと登録できないようにする。
  validates :date, presence: true
  validates :image, presence: true
  validates :events_select_id, numericality: { other_than: 1, message: '出来事を選択してください' }

  # 登録されている出会った人からアイテムを絞り込む検索機能
  def self.research(research)
    if research != ""
      Event.where('met_person LIKE(?)', "%#{research}")
    end 
  end 
end
