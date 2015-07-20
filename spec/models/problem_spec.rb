require 'rails_helper'

RSpec.describe Problem, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status_id) }
    it { should validate_presence_of(:category_id) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:urgency_level_id) }

    it { should have_valid(:title).when('Help') }
    it { should_not have_valid(:title).when(nil, '') }

    it { should have_valid(:description).when('Here is my problem') }
    it { should_not have_valid(:description).when(nil, '') }

    it { should have_valid(:status_id).when('1') }
    it { should_not have_valid(:status_id).when(nil, '') }

    it { should have_valid(:category_id).when('1') }
    it { should_not have_valid(:category_id).when(nil, '') }

    it { should have_valid(:user_id).when('1') }
    it { should_not have_valid(:user_id).when(nil, '') }

    it { should have_valid(:urgency_level_id).when('1') }
    it { should_not have_valid(:urgency_level_id).when(nil, '') }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:status) }
    it { should belong_to(:urgency_level) }
    it { should belong_to(:category) }
    it { should have_many(:solutions).dependent(:destroy)  }
    it { should have_many(:problem_votes).dependent(:destroy)  }
  end
end
