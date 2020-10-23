require 'rails_helper'

RSpec.describe "UserSessions", type: :system do

  describe 'ログイン' do
    context 'ログイン情報が正常のとき' do
      it 'ログインに成功する' do
      end
      it 'フラッシュメッセージが表示' do
      end
    end
    context 'ログイン情報が異常のとき' do
      it 'ログインに失敗する' do
      end
      it 'フラッシュメッセージが表示' do
      end
    end
    context 'ログイン情報が未入力のとき' do
      it 'ログインに失敗する' do
      end
      it 'フラッシュメッセージが表示' do
      end
    end
  end

  describe 'ログアウト' do
    context 'ログアウトボタンを押したとき' do
      it 'ログアウトが成功する' do
      end
    end
  end
end
