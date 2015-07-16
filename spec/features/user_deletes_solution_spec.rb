require 'rails_helper'

feature 'user deletes a solution', %{
  As an authorized user,
  I can delete a solution,
  So that I can erase a solution if I no longer want it on the site.
} do

  # Acceptance Criteria:
  # [x] User can delete a solution they created
  # [x] User can't delete a solution they didn't create
  # [x] User must be authenticated to delete a solution
  # [ ] When user deletes solution, they are shown a confirmation modal and then
  #     a success message upon confirmation
  # [ ] When a user deletes a solution, associated comments and votes are also
  #     deleted

  let(:category) { Category.create(name: "Heat and Essential") }
  let(:urgency_level) { UrgencyLevel.create(id: 1, name: "Immediate") }
  let(:status) { Status.create(id: 1, name: "Open") }
  let(:user) { FactoryGirl.create(:user) }
  let!(:problem) do
    FactoryGirl.create(
      :problem,
      user: user,
      category: category,
      urgency_level: urgency_level,
      status: status
    )
  end
  let!(:solution) do
    Solution.create(
      title: "This is my solution",
      description: "This is my solution description",
      user: user,
      problem: problem,
      accepted: false
    )
  end

  scenario 'authenticated user deletes solution' do
    sign_in(user)
    click_on problem.title
    click_link 'Delete', href: problem_solution_path(problem, solution)

    expect(page).to_not have_content(solution.title)
  end

  scenario "user can't delete problem they didn't create" do
    visit problem_path(problem)

    expect(page).to_not have_link('Delete', href: problem_solution_path(problem, solution))

    sign_in(FactoryGirl.create(:user))
    click_on problem.title

    expect(page).to_not have_link('Delete', href: problem_solution_path(problem, solution))
  end

  pending 'associations votes (and comments?) deleted when problem is deleted'

  pending 'authenticated user sees modal when deleting solution'

end
