require 'rails_helper'

RSpec.describe "Tasks", type: :system do

  describe 'ログイン前' do
    context 'タスク作成するとき' do
      it 'タスク作成が失敗' do
      end
    end
    context 'タスク編集するとき' do
      it 'タスク編集が失敗' do
      end
    end
  end
  
  describe 'ログイン後' do
    describe 'タスク作成' do
      context '入力値が正常のとき' do
        it 'タスク作成が成功' do
        end
        it 'フラッシュメッセージが表示' do
        end
        it '入力値が画面に表示されていること' do
        end
      end
      context '入力値が異常のとき' do
        it 'タスク作成が失敗' do
        end
        it 'フラッシュメッセージが表示' do
        end
        it '入力値が画面に表示されていないこと' do
        end
      end
    end
    
    describe 'タスク編集' do
      context '入力値が正常のとき' do
        it 'タスク編集が成功' do
        end
        it 'フラッシュメッセージが表示' do
        end
        it '入力値が画面に表示されていること' do
        end
      end
      context '入力値が異常のとき' do
        it 'タスク編集が失敗' do
        end
        it 'フラッシュメッセージが表示' do
        end
        it '入力値が画面に表示されていないこと' do
        end
      end
      context '他のユーザータスク編集ページへ遷移したとき' do
        it 'ページ遷移が失敗' do
        end
      end
    end
  
    describe 'タスク削除' do
      context '削除を実行したとき' do
        it 'タスク削除が成功' do
        end
        it 'フラッシュメッセージが表示' do
        end
        it '削除したタスクが画面に表示されていないこと' do
        end
      end
    end
  end
end
