require 'rails_helper'
RSpec.describe "Users", type: :system do

  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      context '入力値が正常のとき' do
        it 'ユーザー作成が成功' do
          visit sign_up_path
          fill_in "Email", with: "test@example.com"
          fill_in "Password", with: "password"
          fill_in "Password confirmation", with: "password"
          click_button "SignUp"
          expect(page).to have_content "User was successfully created."
        end
      end
      context 'メールアドレスが未入力のとき' do
        it 'ユーザー作成が失敗' do
          visit sign_up_path
          fill_in "Email", with: ""
          fill_in "Password", with: "password"
          fill_in "Password confirmation", with: "password"
          click_button "SignUp"
          expect(page).to have_content "Email can't be blank"
        end
      end
      context 'メールアドレスが登録済みのとき' do
        it 'ユーザー作成が失敗' do
          user_duplicate = create(:user)
          visit sign_up_path
          fill_in "Email", with: user_duplicate.email
          fill_in "Password", with: "password"
          fill_in "Password confirmation", with: "password"
          click_button "SignUp"
          expect(page).to have_content "Email has already been taken"
        end
      end
    end
  end
  
  describe 'ログイン後' do
    before do
      @user_login = create(:user)
      sign_in_as @user_login
    end
    describe 'ユーザー編集' do
      context '入力値が正常のとき' do
        it 'ユーザー編集が成功' do
          visit root_path
          click_link "Mypage"
          click_link "Edit"
          fill_in "Email", with: "update@example.com"
          fill_in "Password", with: "password"
          fill_in "Password confirmation", with: "password"
          click_button "Update"
          expect(page).to have_content "User was successfully updated."
        end
      end
      context 'メールアドレスが未入力のとき' do
        it 'ユーザー編集が失敗' do
          visit root_path
          click_link "Mypage"
          click_link "Edit"
          fill_in "Email", with: ""
          fill_in "Password", with: "password"
          fill_in "Password confirmation", with: "password"
          click_button "Update"
          expect(page).to have_content "Email can't be blank"
        end
      end
      context 'メールアドレスが登録済みのとき' do
        it 'ユーザー編集が失敗' do
          user_duplicate = create(:user)
          visit root_path
          click_link "Mypage"
          click_link "Edit"
          fill_in "Email", with: user_duplicate.email
          fill_in "Password", with: "password"
          fill_in "Password confirmation", with: "password"
          click_button "Update"
          expect(page).to have_content "Email has already been taken"
        end
      end
      context '他のユーザー編集ページへ遷移したとき' do
        it 'ページ遷移が失敗' do
          other_user = create(:user)
          visit edit_user_path(other_user)
          expect(page).to have_content "Forbidden access."
          expect(page).to_not have_current_path edit_user_path(other_user)
        end
      end
    end
  
    describe 'マイページ' do
        it '作成済みのタスクがマイページに表示されること' do
          task = create(:task, user: @user_login)
          visit user_path(@user_login)
          expect(page).to have_content task.title
          expect(page).to have_content task.status
        end
        it 'ログインしていないときにマイページへ遷移できないこと' do
          visit root_path
          click_link "Logout"
          visit user_path(@user_login)
          expect(page).to have_content "Login required"
        end
    end
  end
end
