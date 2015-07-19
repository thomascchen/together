require 'rails_helper'

RSpec.describe ProblemVote, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:problem_id) }
    # it { should validate_presence_of(:vote) }
    # it { should validate_presence_of(:directly_affected) }

    it { should validate_numericality_of(:user_id).only_integer }
    # it { should validate_numericality_of(:problem_id).only_integer }
    # it { should validate_numericality_of(:vote).only_integer }
    # it { should validate_numericality_of(:directly_affected).only_integer }

    # it { should validate_inclusion_of(:vote).in_array([0, 1]) }
    # it { should validate_inclusion of(:directly_affected).in_array([0, 1])}

    it { should have_valid(:user_id).when('1') }
    it { should_not have_valid(:user_id).when(nil, '', 'string') }

    it { should have_valid(:problem_id).when('1') }
    it { should_not have_valid(:problem_id).when(nil, '', 'string') }

    # it { should have_valid(:vote).when('0', '1') }
    # it { should_not have_valid(:vote).when(nil, '', '2', '-1') }
    #
    # it { should have_valid(:directly_affected).when('0', '1') }
    # it { should_not have_valid(:directly_affected).when(nil, '', '2', '-1') }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:problem) }
  end
end
