require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "タスクバリデーションテスト" do

    it "タスクを作成できること" do
      task = build(:task)
      expect(task).to be_valid
      expect(task.errors).to be_empty
    end

    it "タイトルが空のときエラー" do
      task_without_title = build(:task, title: nil)
      expect(task_without_title).to be_invalid
      expect(task_without_title.errors[:title]).to eq ["can't be blank"]
    end

    it "ステータスが空のときエラー" do
      task_without_status = build(:task, status: nil)
      expect(task_without_status).to be_invalid
      expect(task_without_status.errors[:status]).to eq ["can't be blank"]
    end

    it "タイトルが重複しているときエラー" do
      task = create(:task)
      task_duplicate_title = build(:task, title: task.title)
      expect(task_duplicate_title).to be_invalid
      expect(task_duplicate_title.errors[:title]).to eq ["has already been taken"]
    end

    it "タイトルがユニークなとき有効" do
      task = create(:task)
      task_with_another_title = build(:task, title: "another_title")
      expect(task_with_another_title).to be_valid
      expect(task_with_another_title.errors).to be_empty
    end
  end
end
