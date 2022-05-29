require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'nickname, age_select_id, sex_select_id, email, password_confirmationが存在する' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end 

      it 'nicknameが重複する場合は登録できない' do
        @user.save
        userx = FactoryBot.build(:user, nickname: @user.nickname)
        userx.valid?
        expect(userx.errors.full_messages).to include "Nickname は既に使われています"
      end 

      it 'age_select_idが空では登録できない' do
        @user.age_select_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include "Age select を選択してください"
      end 

      it 'sex_select_idが空では登録できない' do
        @user.sex_select_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include "Sex select を選択してください"
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end

      it 'emailが重複する場合は登録できない' do
        @user.save
        userx = FactoryBot.build(:user, email: @user.email)
        userx.valid?
        expect(userx.errors.full_messages).to include "Email has already been taken"
      end 

      it 'emailが@を含まない場合は登録できない' do
        @user.email = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = 'aaa'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
      end

      it 'passwordとpassword_comfirmationが一致しないと登録できない' do
        @user.password_confirmation = '000000'
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
    end
  end
end