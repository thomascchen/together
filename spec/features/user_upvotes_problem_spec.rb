require 'rails_helper'

feature 'user upvotes problem', %{
  As an authorized user,
  I can upvote a problem,
  So I can let people know that I think it’s important.
} do

  # Acceptance Criteria:
  # [x] User can upvote a problem they think is especially important
  # [x] User can remove upvote on a problem if they change their mind
  # [x] User cannot upvote on their own problem
  # [x] User can only upvote once per problem
  # [x] User must be authenticated to vote
  # [x] User cannot upvote solved problems
  # [x] Score is displayed on both index and show page for unsolved problems,
  #     but not on solved problem show page

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

  scenario 'authenticated user upvotes and cancels vote on problem', js: true do
    sign_in(FactoryGirl.create(:user))
    click_on "Upvote"
    visit root_path

    expect(page).to have_content('Score: 1')
    expect(page).to_not have_content('Upvote')

    click_on 'Cancel vote'
    visit root_path

    expect(page).to have_content('Score: 0')
    expect(page).to_not have_link('Cancel vote')

    click_on problem.title
    click_on 'Upvote'

    expect(page).to have_content('Score: 1')
    expect(page).to_not have_content('Upvote')

    visit problem_path(problem)
    click_on 'Cancel vote'

    expect(page).to have_content('Score: 0')
    expect(page).to_not have_link('Cancel vote')
  end

  scenario 'authenticated user cannot vote on own problem' do
    sign_in(user)

    expect(page).to_not have_link('Upvote')
  end

  scenario 'unauthenticated user cannot vote on problem' do
    visit root_path

    expect(page).to_not have_link('Upvote')
  end

  scenario 'authenticated user cannot vote on solved problems' do
    solved_problem = FactoryGirl.create(
      :problem,
      user: user,
      category: category,
      urgency_level: urgency_level,
      status: solved_status
    )

    sign_in(FactoryGirl.create(:user))
    click_on 'Solved Problems'

    expect(page).to_not have_link('Upvote')

    click_on solved_problem.title

    expect(page).to_not have_link('Upvote')
  end

end
