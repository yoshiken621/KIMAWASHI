require 'rails_helper'

RSpec.describe Event, type: :model do
  before do
    @event = FactoryBot.build(:event,  image: fixture_file_upload("/a.jpg"))
  end 

  describe '新規記録' do
    context '記録できる場合' do
      it 'date, events_select_id, met_person, checkbox, imageが存在する' do
        expect(@event).to be_valid
      end 
    end
  end
end
