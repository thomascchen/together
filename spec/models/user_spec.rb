require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:unit) }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:building_id) }
    it { should validate_numericality_of(:building_id).only_integer }
    it { should validate_presence_of(:neighborhood_id) }
    it { should validate_numericality_of(:neighborhood_id).only_integer }

    it { should have_valid(:first_name).when('John') }
    it { should_not have_valid(:first_name).when(nil, '') }

    it { should have_valid(:last_name).when('Smith') }
    it { should_not have_valid(:last_name).when(nil, '') }

    it { should have_valid(:email).when('john@example.com') }
    it { should_not have_valid(:email).when(nil, '', 'user', 'user@com') }

    it { should have_valid(:unit).when('1A') }
    it { should_not have_valid(:unit).when(nil, '') }

    it { should have_valid(:role).when('tenant') }
    it { should_not have_valid(:role).when(nil, '') }

    it { should have_valid(:building_id).when('1') }
    it { should_not have_valid(:building_id).when(nil, '', 'one') }

    it { should have_valid(:neighborhood_id).when('1') }
    it { should_not have_valid(:neighborhood_id).when(nil, '', 'one') }

    it 'has matching password confirmation for the password' do
      user = FactoryGirl.create(:user)
      user.password = 'password'
      user.password_confirmation = 'anotherpassword'

      expect(user).to_not be_valid
      expect(user.errors[:password_confirmation]).to_not be_blank
    end
  end

  describe 'associations' do
    it { should belong_to(:neighborhood) }
    it { should belong_to(:building) }
    it { should have_many(:problems).dependent(:destroy) }
    it { should have_many(:solutions).dependent(:destroy) }
    it { should have_many(:problem_votes).dependent(:destroy) }
    it { should have_many(:solution_votes).dependent(:destroy) }
  end

  describe '#name' do
    it 'returns true' do
      user = FactoryGirl.create(:user, first_name: "Grace", last_name: "Boggs")

      expect(user.name).to eq("Grace Boggs")
    end
  end
end
