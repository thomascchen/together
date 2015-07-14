require 'rails_helper'

feature 'user deletes a problem', %{
  As an authenticated user,
  I want to delete a problem,
  So that I can remove a problem that I no longer want it on the site.
} do

  # Acceptance Criteria:
  # [x] User can delete a problem they created
  # [x] User can't delete a problem they didn't create
  # [x] User must be authenticated to delete a problem
  # [x] When user deletes problem, they are shown a confirmation modal and then
  #     a success message upon confirmation
  # [ ] When a user deletes a problem, associated solutions and votes are also
  #     deleted

  let!(:category) { Category.create(name: "Heat and Essential") }
  let!(:urgency_level) { UrgencyLevel.create(id: 1, name: "Immediate") }
  let!(:status) { Status.create(id: 1, name: "Open") }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:problem) do
    FactoryGirl.create(
      :problem,
      user: user,
      category: category,
      urgency_level: urgency_level,
      status: status
    )
  end

  scenario 'user deletes problem they created', js: true do
    sign_in(user)
    click_on problem.title
    click_link 'Delete'

    click_link 'Delete', href: user_problem_path(problem.user, problem)
    expect(page).to have_content("Problem deleted")
    expect(page).to_not have_content("problem.title")
  end

  scenario "user can't delete problem they didn't create" do
    user2 = FactoryGirl.create(:user)
    visit root_path

    click_on problem.title
    expect(page).to_not have_link("Delete", href: '#')

    sign_in(user2)
    click_on problem.title

    expect(page).to_not have_link("Delete", href: '#')
  end

  pending 'associations solutions and votes deleted when problem is deleted'

end
