require 'rails_helper'

RSpec.describe Event, type: :model do
  before do
    @event = FactoryBot.build(:event, image: fixture_file_upload("/a.jpg"))
  end 

  describe '新規記録' do
    context '記録できる場合' do
      it 'date, events_select_id, met_person, checkbox, imageが存在する' do
        expect(@event).to be_valid
      end 
      it 'met_personが存在しない' do
        @event.met_person = ''
        expect(@event).to be_valid
      end
      it 'checkboxが存在しない' do
        @event.checkbox = 0
        expect(@event).to be_valid
      end
    end 
    
    context '記録できない場合' do
      it 'dateが存在しない' do
        @event.date = ''
        @event.valid?
        expect(@event.errors.full_messages).to include "Date can't be blank"
      end 
      it 'events_select_idが存在しない場合' do
        @event.events_select_id = 1
        @event.valid?
        expect(@event.errors.full_messages).to include "Events select を選択してください"
      end
      it 'imageが存在しない場合' do
        @event.image = nil
        @event.valid?
        expect(@event.errors.full_messages).to include "Image can't be blank"
      end 
      it 'userと紐づいていないと登録できない' do
        @event.user = nil
        @event.valid?
        expect(@event.errors.full_messages).to include "User must exist"
      end
    end
  end
end
