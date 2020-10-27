require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  let(:task) { create(:task) }
  let(:user) { create(:user) }

  describe 'ログイン前' do
    context 'タスク作成画面に遷移' do
      it 'ログイン画面に遷移すること' do
        visit new_task_path
        expect(page).to have_content "Login required"
        expect(current_path).to eq login_path
      end
    end
    context 'タスク編集画面に遷移' do
      it 'ログイン画面に遷移すること' do
        visit edit_task_path(task)
        expect(page).to have_content "Login required"
        expect(current_path).to eq login_path
      end
    end
    context 'タスク詳細画面に遷移' do
      it 'タスクの詳細画面に遷移すること' do
        visit task_path(task)
        expect(page).to have_content task.title
        expect(current_path).to eq task_path(task)
      end
    end
    context 'タスク一覧画面に遷移' do
      it '全ユーザーのタスクが確認できること' do
        task_list = create_list(:task, 3)
        visit tasks_path
        expect(page).to have_content task_list[0].title
        expect(page).to have_content task_list[1].title
        expect(page).to have_content task_list[2].title
        expect(current_path).to eq tasks_path
      end
    end
  end

  describe 'ログイン後' do
    before { sign_in_as(user) }

    describe 'タスク作成' do
      context '入力値が正常のとき' do
        it 'タスク作成が成功' do
          visit new_task_path
          fill_in "Title", with: "Test_title"
          fill_in "Content", with: "Test_content"
          select "doing", from: "Status"
          fill_in "Deadline", with: 1.week.from_now
          click_button "Create Task"
          expect(page).to have_content "Task was successfully created."
          expect(page).to have_content "Title: Test_title"
          expect(page).to have_content "Content: Test_content"
          expect(page).to have_content "Status: doing"
          expect(page).to have_content "Deadline: #{1.week.from_now.strftime('%Y/%-m/%-d %-H:%-M')}"
          expect(current_path).to eq '/tasks/1'
        end
      end
      context '入力値が未入力のとき' do
        it 'タスク作成が失敗' do
          visit new_task_path
          fill_in "Title", with: ""
          fill_in "Content", with: "Test_content"
          click_button "Create Task"
          expect(page).to have_content "1 error prohibited this task from being saved:"
          expect(page).to have_content "Title can't be blank"
          expect(page).to_not have_content "Title:"
          expect(page).to_not have_content "Content:"
          expect(page).to_not have_content "Status:"
          expect(page).to_not have_content "Deadline:"
          expect(current_path).to eq tasks_path
        end
      end
      context '入力値が重複しているとき' do
        it 'タスク作成が失敗' do
          visit new_task_path
          fill_in "Title", with: task.title
          click_button "Create Task"
          expect(page).to have_content "1 error prohibited this task from being saved:"
          expect(page).to have_content "Title has already been taken"
          expect(page).to_not have_content "Title:"
          expect(page).to_not have_content "Content:"
          expect(page).to_not have_content "Status:"
          expect(page).to_not have_content "Deadline:"
          expect(current_path).to eq tasks_path
        end
      end
    end
    
    describe 'タスク編集' do
      let!(:task) { create(:task, user: user) }
      let(:other_task) { create(:task, user: user) }
      let(:other_user) { create(:user) }
      let(:other_user_task) { create(:task, user: other_user) }
      before { visit edit_task_path(task) }

      context '入力値が正常のとき' do
        it 'タスク編集が成功' do
          fill_in "Title", with: "Test_update_title"
          fill_in "Content", with: "Test_update_content"
          select "done", from: "Status"
          fill_in "Deadline", with: 2.week.from_now.strftime("%Y\t%m/%d%H%M")
          click_button "Update Task"
          expect(page).to have_content "Task was successfully updated."
          expect(page).to have_content "Title: Test_update_title"
          expect(page).to have_content "Content: Test_update_content"
          expect(page).to have_content "Status: done"
          expect(page).to have_content "Deadline: #{2.week.from_now.strftime('%Y/%-m/%-d %-H:%-M')}"
          expect(current_path).to eq task_path(task)
        end
      end
      context '入力値が未入力のとき' do
        it 'タスク編集が失敗' do
          fill_in "Title", with: nil
          fill_in "Content", with: "Test_content"
          select "todo", from: "Status"
          click_button "Update Task"
          expect(page).to have_content "1 error prohibited this task from being saved:"
          expect(page).to_not have_content "Title:"
          expect(page).to_not have_content "Content:"
          expect(page).to_not have_content "Status:"
          expect(page).to_not have_content "Deadline:"
          expect(current_path).to eq task_path(task)
        end
      end
      context 'タイトルが重複しているとき' do
        it 'タスク編集が失敗' do
          fill_in "Title", with: other_task.title
          fill_in "Content", with: "Test_content"
          select "todo", from: "Status"
          click_button "Update Task"
          expect(page).to have_content "1 error prohibited this task from being saved:"
          expect(page).to have_content "Title has already been taken"
          expect(page).to_not have_content "Title:"
          expect(page).to_not have_content "Content:"
          expect(page).to_not have_content "Status:"
          expect(page).to_not have_content "Deadline:"
          expect(current_path).to eq task_path(task)
        end
      end
      context '他のユーザータスク編集ページへ遷移したとき' do
        it 'ページ遷移が失敗' do
          visit edit_task_path(other_user_task)
          expect(page).to have_content "Forbidden access."
          expect(current_path).to eq root_path
        end
      end
    end
  
    describe 'タスク削除' do
      let!(:task) { create(:task, user: user) }

      it 'タスク削除が成功' do
        visit tasks_path
        page.accept_confirm do
          click_link 'Destroy', href: task_path(task)
        end
        expect(page).to have_content "Task was successfully destroyed."
        expect(page).to_not have_content "Title: #{task.title}"
        expect(page).to_not have_content "Content: #{task.content}"
        expect(page).to_not have_content "Status: #{task.status}"
        expect(page).to_not have_content "Deadline: #{task.deadline}"
        expect(current_path).to eq tasks_path
      end
    end
  end
end
