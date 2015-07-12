require 'rails_helper'

feature 'user creates a new problem', %{
  As an authorized user,
  I want to submit a new problem in my building,
  So that I can get help solving it with my neighbors
} do

  # Acceptance Criteria
  # [x] User must specify a title, description, category and urgency level for
  #     their problem
  # [x] After successful submission, user is shown a success message, and they
  #     are redirected to their problem show page
  # [x] If user submits incomplete information, they are shown an error message
  #     and the form is re-rendered with previously entered information
  # [x] User must be authenticated to post a new problem

  let!(:user) { FactoryGirl.create(:user) }
  let!(:category) { Category.create(name: 'Heat and Essential') }
  let!(:urgency_level) { UrgencyLevel.create(name: 'Immediate') }
  let!(:status) { Status.create(id: 1, name: 'Open') }

  scenario 'authenticated user enters valid information' do
    sign_in(user)
    click_link 'Report an Issue'
    fill_in 'Title', with: "Heat's broken!"
    fill_in 'Description', with: 'Heat is broken yet again!'
    choose "problem_category_id_#{category.id}"
    choose "problem_urgency_level_id_#{urgency_level.id}"

    click_button('Submit')

    expect(page).to have_content('Problem submitted')
    expect(page).to have_content("Heat's broken!")
  end

  scenario 'authenticated user enters invalid information' do
    sign_in(user)
    click_link('Report an Issue')
    fill_in 'Description', with: 'Heat is broken yet again!'
    choose "problem_urgency_level_id_#{urgency_level.id}"

    click_button('Submit')
    expect(page).to have_content('Problem not saved')
    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Heat's broken!")
  end

  scenario 'unauthenticated user cannot submit a new problem' do
    visit root_path
    expect(page).to_not have_content('Report an Issue')
  end
end
