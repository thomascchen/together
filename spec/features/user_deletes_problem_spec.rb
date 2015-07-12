require 'rails_helper'

feature 'user creates a new problem', %{
  As an authenticated user,
  I want to delete a problem,
  So that I can remove a problem that I no longer want it on the site.
} do

  # Acceptance Criteria:
  # [x] User can delete a problem they created
  # [x] User can't delete a problem they didn't create
  # [x] User must be authenticated to delete a problem
  # [ ] When user deletes problem, they are shown a confirmation modal and then
  #     a success message upon confirmation

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

  scenario 'user deletes problem they created' do
    sign_in(user)
    click_on problem.title
    click_on 'Delete'

    # expect JS confirmation
    expect(page).to have_content("Problem deleted")
    expect(page).to_not have_content("problem.title")
  end

  scenario "user can't delete problem they didn't create" do
    user2 = FactoryGirl.create(:user)
    visit root_path

    click_on problem.title
    expect(page).to_not have_content("Delete")

    sign_in(user2)
    click_on problem.title

    expect(page).to_not have_content("Delete")
  end

end
