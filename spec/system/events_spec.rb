require 'rails_helper'

RSpec.describe "服装投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @event = FactoryBot.build(:event)
    # image_path = Rails.root.join('spec/fixtures/a.jpg')
  end
  context '服装投稿ができる時' do
    it 'ログインしたユーザーは新規登録できる' do
      visit new_user_session_path
      fill_in 'Nickname', with: @user.nickname
      fill_in 'Password', with: @user.password
      find('input[value="Log in"]').click
      expect(current_path).to eq(root_path)
      visit new_event_path
      fill_in 'event_date', with: @event.date
      attach_file 'item-image', '/Users/apple/KIMAWASHI/spec/fixtures/a.jpg', make_visible: true
      select '遊び', from: 'event[events_select_id]'
      fill_in 'event_met_person', with: @event.met_person
      find('input[type="checkbox"]').click
      find('input[value="完了"]').click
      expect(current_path).to eq(root_path)
    end
  end
end
