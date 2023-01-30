# frozen_string_literal: true

describe Task, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:todo_id) }
  end

  describe 'associations' do
    it { should belong_to(:todo) }
  end
end
