require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build (:user)
  end 

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'nickname, age_select_id, sex_select_id, email, password, password_confirmationが存在する' do
        expect(@user).to be_valid
      end 
    end 

    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
      end 
      it 'age_select_idが空では登録できない' do
      end
      it 'sex_select_idが空では登録できない' do
      end 
    end 
  end 
end
