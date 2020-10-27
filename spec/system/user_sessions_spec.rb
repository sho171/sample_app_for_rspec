require 'rails_helper'

RSpec.describe "UserSessions", type: :system do

  describe 'ログイン' do
    context '入力値が正常のとき' do
      it 'ログインに成功する' do
        user_login = create(:user)
        sign_in_as user_login
        expect(page).to have_content "Login successful"
      end
    end
    context '入力値が未入力のとき' do
      it 'ログインに失敗する' do
        user_login_fail = create(:user)
        visit login_path
        fill_in "Email", with: user_login_fail.email
        fill_in "Password", with: ""
        click_button "Login"
        expect(page).to have_content "Login failed"
      end
    end
  end

  describe 'ログアウト' do
    context 'ログアウトボタンを押したとき' do
      it 'ログアウトが成功する' do
        user_logout = create(:user)
        sign_in_as user_logout
        visit root_path
        click_link "Logout"
        expect(page).to have_content "Logged out"
      end
    end
  end
end
