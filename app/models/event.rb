class Event < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :events_select
  has_one_attached :image
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :events_select_id, numericality: { other_than: 1, message: '出来事を選択してください' }
  validates :date, presence: true
  validates :image, presence: true
end
