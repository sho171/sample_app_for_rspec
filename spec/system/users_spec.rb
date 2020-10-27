require 'rails_helper'
RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

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
          expect(current_path).to eq login_path
        end
      end
      context 'メールアドレスが未入力のとき' do
        it 'ユーザー作成が失敗' do
          visit sign_up_path
          fill_in "Email", with: nil
          fill_in "Password", with: "password"
          fill_in "Password confirmation", with: "password"
          click_button "SignUp"
          expect(page).to have_content "Email can't be blank"
          expect(current_path).to eq users_path
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
          expect(page).to have_content "1 error prohibited this user from being saved"
          expect(page).to have_content "Email has already been taken"
          expect(current_path).to eq users_path
          expect(page).to have_field "Email", with: user_duplicate.email
        end
      end
    end
  end
  
  describe 'ログイン後' do
    before { sign_in_as(user) }
    
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
          expect(current_path).to eq user_path(user)
        end
      end
      context 'メールアドレスが未入力のとき' do
        it 'ユーザー編集が失敗' do
          visit root_path
          click_link "Mypage"
          click_link "Edit"
          fill_in "Email", with: nil
          fill_in "Password", with: "password"
          fill_in "Password confirmation", with: "password"
          click_button "Update"
          expect(page).to have_content "Email can't be blank"
          expect(page).to have_content "1 error prohibited this user from being saved"
          expect(current_path).to eq user_path(user)
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
          expect(page).to have_content "1 error prohibited this user from being saved"
        end
      end
      context '他のユーザー編集ページへ遷移したとき' do
        it 'ページ遷移が失敗' do
          other_user = create(:user)
          visit edit_user_path(other_user)
          expect(page).to have_content "Forbidden access."
          expect(current_path).to eq user_path(user)
        end
      end
    end
  
    describe 'マイページ' do
        it '作成済みのタスクがマイページに表示されること' do
          task = create(:task, user: user)
          visit user_path(user)
          expect(page).to have_content "You have 1 task"
          expect(page).to have_content task.title
          expect(page).to have_content task.status
          expect(page).to have_content "Show"
          expect(page).to have_content "Edit"
          expect(page).to have_content "Destroy"
        end
        it 'ログインしていないときにマイページへ遷移できないこと' do
          visit root_path
          click_link "Logout"
          visit user_path(user)
          expect(page).to have_content "Login required"
        end
    end
  end
end
