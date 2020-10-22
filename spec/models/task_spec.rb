require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "タスクバリデーションテスト" do
    let(:user) { FactoryBot.create(:user) }

    it "タスクを作成できること" do
      task = FactoryBot.build(:task, user: user)
      expect(task).to be_valid
    end

    it "タイトルに値があるとき有効" do
      task = FactoryBot.build(:task, title: "test_title", user: user)
      expect(task).to be_valid
    end

    it "タイトルが空のときエラー" do
      task = FactoryBot.build(:task, title: nil, user: user)
      task.valid?
      expect(task.errors[:title]).to include("can't be blank")
    end

    it "タイトルがユニークなとき有効" do
      task1 = FactoryBot.create(:task, title: "test_task1", user: user)
      task2 = FactoryBot.build(:task, title: "test_task2", user: user)
      expect(task2).to be_valid
    end

    it "タイトルが重複しているときエラー" do
      task1 = FactoryBot.create(:task, title: "test_task", user: user)
      task2 = FactoryBot.build(:task, title: "test_task", user: user)
      task2.valid?
      expect(task2.errors[:title]).to include("has already been taken")
    end

    it "ステータスに値があるとき有効" do
      task = FactoryBot.build(:task, status: 0, user: user)
      expect(task).to be_valid
    end

    it "ステータスが空のときエラー" do
      task = FactoryBot.build(:task, status: nil, user: user)
      task.valid?
      expect(task.errors[:status]).to include("can't be blank")
    end
  end
end
