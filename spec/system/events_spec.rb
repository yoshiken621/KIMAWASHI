require 'rails_helper'

RSpec.describe "服装投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @event = FactoryBot.build(:event)
  end
  context '服装投稿ができる時' do
    it 'ログインしたユーザーは新規登録できる' do
      sign_in(@user)
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
  context '服装投稿ができないとき' do
    it 'ログインしていないユーザーはログインページに遷移される' do
      visit root_path
      expect(current_path).to eq(new_user_session_path)
    end
    it '誤った投稿内容では投稿できずに投稿ページに戻ってくる' do
      sign_in(@user)
      visit new_event_path
      find('input[value="完了"]').click
      expect(current_path).to eq(events_path)
    end
  end
end

RSpec.describe '投稿編集', type: :system do
  before do
    @event1 = FactoryBot.create(:event, image: fixture_file_upload("/a.jpg"))
    @event2 = FactoryBot.create(:event, image: fixture_file_upload("/a.jpg"))
  end
  context '投稿編集ができる時' do
    it 'ログインしたユーザーは自分が投稿した服装の投稿内容を編集できる' do
      sign_in(@event1.user)
      visit event_path(@event1)
      expect(page).to have_link '編集', href: edit_event_path(@event1)
      visit edit_event_path(@event1)
      expect(find('#event_date').value).to eq('2014-09-25')
    end
  end
end
