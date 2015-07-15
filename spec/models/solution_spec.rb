require 'rails_helper'

RSpec.describe Solution, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:problem_id) }

    it { should have_valid(:title).when('I have an solution') }
    it { should_not have_valid(:title).when(nil, '') }

    it { should have_valid(:description).when('Here is my solution') }
    it { should_not have_valid(:description).when(nil, '') }

    it { should have_valid(:accepted).when(true, false) }
    it { should_not have_valid(:accepted).when(nil, '') }

    it { should have_valid(:user_id).when('1') }
    it { should_not have_valid(:user_id).when(nil, '', 'string') }

    it { should have_valid(:problem_id).when('1') }
    it { should_not have_valid(:problem_id).when(nil, '', 'string') }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:problem) }
  end
end
