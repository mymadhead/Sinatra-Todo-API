# frozen_string_literal: true

describe Todo, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
