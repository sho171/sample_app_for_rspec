require 'rails_helper'

RSpec.describe "Users", type: :system do

  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      context '入力値が正常のとき' do
        it 'ユーザー作成が成功' do
        end
        it 'フラッシュメッセージが表示' do
        end
      end
      context 'メールアドレスが未入力のとき' do
        it 'ユーザー作成が失敗' do
        end
        it 'フラッシュメッセージが表示' do
        end
      end
      context 'メールアドレスが登録済みのとき' do
        it 'ユーザー作成が失敗' do
        end
        it 'フラッシュメッセージが表示' do
        end
      end
    end
  end
  
  describe 'ログイン後' do
    describe 'ユーザー編集' do
      context '入力値が正常のとき' do
        it 'ユーザー編集が成功' do
        end
        it 'フラッシュメッセージが表示' do
        end
      end
      context 'メールアドレスが未入力のとき' do
        it 'ユーザー編集が失敗' do
        end
      end
      context 'メールアドレスが登録済みのとき' do
        it 'ユーザー編集が失敗' do
        end
      end
      context '他のユーザー編集ページへ遷移したとき' do
        it 'ページ遷移が失敗' do
        end
        it 'フラッシュメッセージが表示' do
        end
      end
    end
  
    describe 'マイページ' do
      context 'タスクを作成したとき' do
        it 'タスクが表示されること' do
        end
      end
      context 'ログインしていないとき' do
        it 'マイページへ遷移できないこと' do
        end
      end
    end
  end
end
