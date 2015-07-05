require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:unit) }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:building_id) }
    it { should validate_presence_of(:neighborhood_id) }

    it { should have_valid(:first_name).when('John') }
    it { should_not have_valid(:first_name).when(nil, '') }

    it { should have_valid(:last_name).when('Smith') }
    it { should_not have_valid(:last_name).when(nil, '') }

    it { should have_valid(:email).when('john@example.com') }
    it { should_not have_valid(:email).when(
      nil,
      '',
      'user',
      'user@com',
      'user.com'
    ) }

    it { should have_valid(:last_name).when('Smith') }
    it { should_not have_valid(:last_name).when(nil, '') }

    it 'has matching password confirmation for the password' do
      user = User.new
      user.password = 'password'
      user.password_confirmation = 'anotherpassword'

      expect(user).to_not be_valid
      expect(user.errors[:password_confirmation]).to_not be_blank
    end
  end

  describe 'associations' do
    it { should belong_to(:neighborhood) }
    it { should belong_to(:building) }
  end
end
