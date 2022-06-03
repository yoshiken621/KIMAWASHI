require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      visit new_user_registration_path
      fill_in 'Nickname', with: @user.nickname
      select '10代', from: 'user[age_select_id]'
      select '男性', from: 'user[sex_select_id]'
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password_confirmation
      expect{find('input[value="登録"]').click}.to change { User.count }.by(1)
      expect(current_path).to eq(root_path)
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      visit new_user_registration_path
      fill_in 'Nickname', with: ''
      select '--', from: 'user[age_select_id]'
      select '--', from: 'user[sex_select_id]'
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      fill_in 'Password confirmation', with: ''
      expect{find('input[value="登録"]').click}.to change { User.count }.by(0)
      expect(current_path).to eq(user_registration_path)
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ユーザーログインができるとき' do
    it '保存されているユーザー情報と合致すればログインができる' do
      sign_in(@user)
    end
  end
  context 'ユーザーログインができないとき' do
    it '保存されているユーザー情報と合致しないとログインできない' do
      visit new_user_session_path
      fill_in 'Nickname', with: ''
      fill_in 'Password', with: ''
      find('input[value="Log in"]').click
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
