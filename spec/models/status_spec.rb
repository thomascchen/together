require 'rails_helper'

RSpec.describe Status, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }

    it { should have_valid(:name).when('Open', 'Solved') }
    it { should_not have_valid(:name).when(nil, '') }
  end

  describe 'associations' do
    it { should have_many(:problems) }
  end
end
