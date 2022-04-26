class EventsSelect < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '仕事・学校' },
    { id: 3, name: '遊び' },
    { id: 4, name: 'デート' },
    { id: 5, name: 'その他'}
  ]

  include ActiveHash::Associations
  has_many :events
end