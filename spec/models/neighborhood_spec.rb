require 'rails_helper'

RSpec.describe Neighborhood, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should have_valid(:name).when('Jamaica Plain', 'Allston') }
    it { should_not have_valid(:name).when(nil, '', 'Cambridge') }
  end

  describe 'associations' do
    it { should have_many(:buildings) }
    it { should have_many(:users) }
  end
end
