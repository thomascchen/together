require 'rails_helper'

feature 'user views unsolved problems', %{
  As an authorized user,
  I can view a list of unsolved problems,
  So I can learn about existing problems in my building.
} do

  # Acceptance Criteria
  # [x] User can view a list of unsolved problems when visiting the root path
  # [x] Unsolved problems should be sorted by urgency level
  # [x] Title, category, urgency level, status, user's first and last name, and
  #     last updated time should be displayed alongside each problem
  # [x] User can click in to problem show page and see all of the same
  #     information for each problem

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

  scenario 'user views list of unsolved problems' do
    urgency_level2 = UrgencyLevel.create(id: 3, name: "Not Urgent")
    status2 = Status.create(id: 2, name: "Solved")
    problem2 = FactoryGirl.create(
      :problem,
      user: user,
      category: category,
      urgency_level: urgency_level,
      status: status2
    )
    problem3 = FactoryGirl.create(
      :problem,
      user: user,
      category: category,
      urgency_level: urgency_level2,
      status: status
    )

    visit root_path

    expect(page).to have_content(problem.title)
    expect(page).to have_content(problem.category.name)
    expect(page).to have_content(problem.urgency_level.name)
    expect(page).to have_content(problem.status.name)
    expect(page).to have_content(problem.user.name)
    expect(page).to have_content(problem.updated_at)
    expect(page).to have_content(problem3.title)
    expect(page).to_not have_content(problem2.title)
    expect(page).to have_selector("div ul:nth-child(1) li", text: problem.title)
    expect(page).to have_selector("div ul:nth-child(2) li", text: problem3.title)
  end

  scenario 'user views problem show page' do
    visit root_path
    click_on problem.title

    expect(page).to have_content(problem.title)
    expect(page).to have_content(problem.category.name)
    expect(page).to have_content(problem.urgency_level.name)
    expect(page).to have_content(problem.status.name)
    expect(page).to have_content(problem.user.name)
    expect(page).to have_content(problem.updated_at)
  end
end
