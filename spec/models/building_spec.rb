require 'rails_helper'

RSpec.describe Building, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:neighborhood_id) }

    it { should have_valid(:street).when('21 Jumpstreet') }
    it { should_not have_valid(:street).when(nil, '') }

    it { should have_valid(:city).when('Boston') }
    it { should_not have_valid(:city).when(nil, '') }

    it { should have_valid(:state).when('Massachusetts', 'MA') }
    it { should_not have_valid(:state).when(nil, '') }

    it { should have_valid(:zip).when('02130', '91210') }
    it { should_not have_valid(:zip).when(nil, '', '0123', '012345') }
  end

  describe 'associations' do
    it { should belong_to(:neighborhood) }
  end
end
