require 'rails_helper'

RSpec.describe "UserSessions", type: :system do

  describe 'ログイン' do
    context '入力値が正常のとき' do
      it 'ログインに成功する' do
        expect 'フラッシュメッセージが表示'
      end
    end
    context '入力値が未入力のとき' do
      it 'ログインに失敗する' do
        expect 'フラッシュメッセージが表示'
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
