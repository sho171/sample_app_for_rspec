require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  let(:user) { create(:user) }

  describe 'ログイン' do
    context '入力値が正常のとき' do
      it 'ログインに成功する' do
        visit login_path
        fill_in "Email", with: user.email
        fill_in "Password", with: "password"
        click_button "Login"
        expect(page).to have_content "Login successful"
        expect(current_path).to eq root_path
      end
    end
    context '入力値が未入力のとき' do
      it 'ログインに失敗する' do
        visit login_path
        fill_in "Email", with: user.email
        fill_in "Password", with: nil
        click_button "Login"
        expect(page).to have_content "Login failed"
        expect(current_path).to eq login_path
      end
    end
  end

  describe 'ログアウト' do
    context 'ログアウトボタンを押したとき' do
      it 'ログアウトが成功する' do
        sign_in_as user
        visit root_path
        click_link "Logout"
        expect(page).to have_content "Logged out"
        expect(current_path).to eq root_path
      end
    end
  end
end
