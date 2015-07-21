require 'rails_helper'

feature 'user upvotes problem', %{
  As an authorized user,
  I can upvote a problem,
  So I can let people know that I think it’s important.
} do

  # Acceptance Criteria:
  # [x] User can upvote a problem they think is especially important
  # [x] User can remove upvote on a problem if they change their mind
  # [x] User can only upvote once per problem
  # [x] User must be authenticated to vote
  # [x] Score is displayed on both index and show page for unsolved problems,
  #     but not on solved problem show page

  let(:category) { Category.create(name: "Heat and Essential") }
  let(:urgency_level) { UrgencyLevel.create(id: 1, name: "Immediate") }
  let(:open_status) { Status.create(id: 1, name: "Open") }
  let!(:solved_status) { Status.create(id: 2, name: "Solved") }
  let(:user) { FactoryGirl.create(:user) }
  let!(:open_problem) do
    FactoryGirl.create(
      :problem,
      user: user,
      category: category,
      urgency_level: urgency_level,
      status: open_status
    )
  end

  scenario 'authenticated user upvotes and cancels vote on problem index',
    js: true do
      sign_in(FactoryGirl.create(:user))
      click_on("+ 0")

      expect(page).to have_link('+ 1')

      click_on('+ 1')

      expect(page).to have_link('+ 0')
      expect(page).to_not have_content('+ 1')
    end

  scenario 'authenticated user upvotes and cancels vote on problem show page',
    js: true do
      sign_in(FactoryGirl.create(:user))
      visit problem_path(open_problem)
      click_on "+ 0"

      expect(page).to have_link('+ 1')

      click_on '+ 1'

      expect(page).to have_content('+ 0')
      expect(page).to_not have_content('+ 1')
    end

    scenario 'unauthenticated user cannot vote on problem' do
    visit root_path

    expect(page).to_not have_link('+ 0')
  end
end
