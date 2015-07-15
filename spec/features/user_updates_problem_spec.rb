require 'rails_helper'

feature 'user updates problem', %{
  As an authorized user,
  I can update a problem that I submitted,
  So that I can let people know if something has changed.
} do

  # Acceptance Criteria
  # [x] User can update a problem they created
  # [x] User can't update a problem they didn't create
  # [x] When user visits update problem page, they are shown a form that is
  #     filled out with existing information that they can update and resubmit
  # [x] When user submits updated problem, they are taken to the problem show
  #     page and given a success message
  # [x] If user submits invalid information, form is re-rendered and they are
  #     given error message.

  let!(:category) { Category.create(name: "Heat and Essential") }
  let!(:urgency_level) { UrgencyLevel.create(id: 1, name: "Immediate") }
  let!(:status) { Status.create(id: 1, name: "Open") }
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

  scenario 'authenticated user updates problem with valid information' do
    category2 = Category.create(name: 'Repairs')
    urgency_level2 = UrgencyLevel.create(id: 2, name: 'Not Urgent')
    sign_in(user)
    click_on problem.title
    click_on "Edit"
    fill_in 'Title', with: 'Landlord sucks!'
    fill_in 'Description', with: 'Heat is still broke!'
    choose "problem_category_id_#{category2.id}"
    choose "problem_urgency_level_id_#{urgency_level2.id}"
    click_on 'Submit'

    expect(page).to have_content('Problem updated')
    expect(page).to have_content('Landlord sucks!')
    expect(page).to have_content('Heat is still broke!')
    expect(page).to have_content(category2.name)
    expect(page).to have_content(urgency_level2.name)
    expect(page).to_not have_content("Heat's broken")
  end

  scenario 'authenticated user updates problem with invalid information' do
    sign_in(user)
    click_on problem.title
    click_on "Edit"

    fill_in 'Title', with: ''
    fill_in 'Description', with: 'Heat is still broke!'
    choose "problem_category_id_#{category.id}"
    choose "problem_urgency_level_id_#{urgency_level.id}"
    click_on 'Submit'

    expect(page).to have_content('Problem not updated')
    expect(page).to have_content("can't be blank")
    expect(page).to have_selector('form')
  end

  scenario 'unauthenticated user cannot update problem' do
    visit problem_path(problem)
    expect(page).to_not have_link('Update')

    visit edit_user_problem_path(user, problem)
    expect(page).to_not have_selector('form')
  end
end
