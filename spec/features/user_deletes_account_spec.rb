require 'rails_helper'

feature 'user signs in', %{
  As an authenticated user
  I want to delete my account
  So that I can erase my account information
} do

  # Acceptance Criteria:
  # [x] If I am an authenticated user, I can delete my account
  # [x] If I am not logged in, I cannot delete my account
  # [ ] If I delete my account, all associated problems, solutions, and votes
  #     will also be deleted

  scenario 'authenticated user deletes account' do
    user = FactoryGirl.create(:user)
    sign_in(user)
    visit root_path
    click_link 'Account'
    click_button 'Delete My Account'

    expect(page).to have_content('Bye')
  end

  scenario 'unauthenticated cannot delete acount' do
    visit root_path

    expect(page).to_not have_content('Account')
    expect(page).to_not have_content('Sign Out')
  end

  pending 'deleting account deletes associated problems, solutions, votes'

end
