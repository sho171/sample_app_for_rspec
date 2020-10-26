require 'rails_helper'

RSpec.describe "Tasks", type: :system do

  describe 'ログイン前' do
    context 'タスク作成画面に遷移' do
      it 'ログイン画面に遷移すること' do
      end
    end
    context 'タスク編集画面に遷移' do
      it 'ログイン画面に遷移すること' do
      end
    end
  end
  
  describe 'ログイン後' do
    describe 'タスク作成' do
      context '入力値が正常のとき' do
        it 'タスク作成が成功' do
          expect 'フラッシュメッセージが表示'
          expect '入力値が画面に表示されていること'
        end
      end
      context '入力値が異常のとき' do
        it 'タスク作成が失敗' do
          expect 'フラッシュメッセージが表示'
          expect '入力値が画面に表示されていないこと'
        end
      end
    end
    
    describe 'タスク編集' do
      context '入力値が正常のとき' do
        it 'タスク編集が成功' do
          expect 'フラッシュメッセージが表示'
          expect '入力値が画面に表示されていること'
        end
      end
      context '入力値が異常のとき' do
        it 'タスク編集が失敗' do
          expect 'フラッシュメッセージが表示'
          expect '入力値が画面に表示されていないこと'
        end
      end
      context '他のユーザータスク編集ページへ遷移したとき' do
        it 'ページ遷移が失敗' do
        end
      end
    end
  
    describe 'タスク削除' do
      it 'タスク削除が成功' do
        expect 'フラッシュメッセージが表示'
        expect '削除したタスクが画面に表示されていないこと'
      end
    end
  end
end
