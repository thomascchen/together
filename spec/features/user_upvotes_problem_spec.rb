require 'rails_helper'

feature 'user upvotes problem', %{
  As an authorized user,
  I can upvote a problem,
  So I can let people know that I think it’s important.
} do

  # Acceptance Criteria:
  # [ ] User can upvote a problem they think is especially important
  # [ ] User can remove upvote on a problem if they change their mind
  # [ ] User cannot upvote on their own problem
  # [ ] User can only upvote once per problem
  # [ ] User must be authenticated to vote

  let(:category) { Category.create(name: "Heat and Essential") }
  let(:urgency_level) { UrgencyLevel.create(id: 1, name: "Immediate") }
  let(:open_status) { Status.create(id: 1, name: "Open") }
  let!(:solved_status) { Status.create(id: 2, name: "Solved") }
  let(:user) { FactoryGirl.create(:user) }
  let!(:problem) do
    FactoryGirl.create(
      :problem,
      user: user,
      category: category,
      urgency_level: urgency_level,
      status: open_status
    )
  end

  scenario 'authenticated user upvotes problem' do
    sign_in(user)
    
    click_on "Upvote"

    expect(page).to have_content('Score: 1')
    expect(page).to have_content('Cancel upvote')
    expect(page).to_not have_content('Upvote')
  end

  pending 'authenticated user removes upvote on problem'
  pending 'unauthenticated user cannot vote on problem'

end
