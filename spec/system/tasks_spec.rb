require 'rails_helper'

RSpec.describe "Tasks", type: :system do

  describe 'ログイン前' do
    context 'タスク作成画面に遷移' do
      it 'ログイン画面に遷移すること' do
        visit new_task_path
        expect(page).to have_current_path "/login"
        expect(page).to have_content "Login required"
      end
    end
    context 'タスク編集画面に遷移' do
      it 'ログイン画面に遷移すること' do
        task_edit = create(:task)
        visit edit_task_path(task_edit)
        expect(page).to have_current_path "/login"
        expect(page).to have_content "Login required"
      end
    end
  end
  
  describe 'ログイン後' do
      before do
        @user_login = create(:user)
        sign_in_as @user_login
      end
    describe 'タスク作成' do

      context '入力値が正常のとき' do
        it 'タスク作成が成功' do
          visit new_task_path
          fill_in "Title", with: "Test_title"
          fill_in "Content", with: "Test_content"
          select "todo", from: "Status"
          fill_in "Deadline", with: 1.week.from_now
          click_button "Create Task"
          expect(page).to have_content "Task was successfully created."
          expect(page).to have_content "Title: Test_title"
          expect(page).to have_content "Content: Test_content"
          expect(page).to have_content "Status: todo"
          expect(page).to have_content "Deadline: #{1.week.from_now.strftime('%Y/%-m/%-d %-H:%-M')}"
        end
      end
      context '入力値が未入力のとき' do
        it 'タスク作成が失敗' do
          visit new_task_path
          click_button "Create Task"
          expect(page).to have_content "error prohibited this task from being saved:"
          expect(page).to_not have_content "Title:"
          expect(page).to_not have_content "Content:"
          expect(page).to_not have_content "Status:"
          expect(page).to_not have_content "Deadline:"
        end
      end
      context '入力値が重複しているとき' do
        it 'タスク作成が失敗' do
          visit new_task_path
          task_first = create(:task)
          fill_in "Title", with: "#{task_first.title}"
          click_button "Create Task"
          expect(page).to have_content "Title has already been taken"
          expect(page).to_not have_content "Title:"
          expect(page).to_not have_content "Content:"
          expect(page).to_not have_content "Status:"
          expect(page).to_not have_content "Deadline:"
        end
      end
    end
    
    describe 'タスク編集' do
      context '入力値が正常のとき' do
        it 'タスク編集が成功' do
          task_edit = create(:task, user: @user_login)
          visit edit_task_path(task_edit)
          fill_in "Title", with: "Test_update_title"
          fill_in "Content", with: "Test_update_content"
          select "todo", from: "Status"
          fill_in "Deadline", with: 2.week.from_now.strftime("%Y\t%m/%d%H%M")
          click_button "Update Task"
          expect(page).to have_content "Task was successfully updated."
          expect(page).to have_content "Title: Test_update_title"
          expect(page).to have_content "Content: Test_update_content"
          expect(page).to have_content "Status: todo"
          expect(page).to have_content "Deadline: #{2.week.from_now.strftime('%Y/%-m/%-d %-H:%-M')}"
        end
      end
      context '入力値が未入力のとき' do
        it 'タスク編集が失敗' do
          task_edit = create(:task, user: @user_login)
          visit edit_task_path(task_edit)
          fill_in "Title", with: ""
          fill_in "Content", with: ""
          select "todo", from: ""
          fill_in "Deadline", with: ""
          click_button "Update Task"
          expect(page).to have_content "error prohibited this task from being saved:"
          expect(page).to_not have_content "Title:"
          expect(page).to_not have_content "Content:"
          expect(page).to_not have_content "Status:"
          expect(page).to_not have_content "Deadline:"
        end
      end
      context '他のユーザータスク編集ページへ遷移したとき' do
        it 'ページ遷移が失敗' do
          other_user = create(:user)
          other_user_task = create(:task, user: other_user)
          visit edit_task_path(other_user_task)
          expect(page).to have_content "Forbidden access."
        end
      end
    end
  
    describe 'タスク削除' do
      it 'タスク削除が成功' do
        task_delete = create(:task, user: @user_login)
        visit tasks_path
        page.accept_confirm do
          click_link 'Destroy', href: task_path(task_delete)
        end
        expect(page).to have_content "Task was successfully destroyed."
        expect(page).to_not have_content "Title: #{task_delete.title}"
        expect(page).to_not have_content "Content: #{task_delete.content}"
        expect(page).to_not have_content "Status: #{task_delete.status}"
        expect(page).to_not have_content "Deadline: #{task_delete.deadline}"
      end
    end
  end
end
