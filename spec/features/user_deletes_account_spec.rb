require 'rails_helper'

feature 'user signs in', %{
  As an authenticated user
  I want to delete my account
  So that I can erase my account information
} do

  # Acceptance Criteria:
  # [x] If I am an authenticated user, I can delete my account
  # [x] If I am not logged in, I cannot delete my account
  # [x] Associated problems, solutions, problem votes and solution votes are
  #     also deleted when an account is deleted

  let(:allston) { Neighborhood.create(name: "Allston") }
  let(:building) do
    Building.create(
      street: "21 Jump Street",
      city: "Boston",
      state: "MA",
      zip: "02130",
      neighborhood: allston
    )
  end
  let(:user) { FactoryGirl.create(:user, building: building, neighborhood: allston ) }

  scenario 'authenticated user deletes account' do
    sign_in(user)
    visit root_path
    click_link 'Account'
    click_link 'Edit Profile'
    click_on 'Delete Account'

    expect(page).to have_content('Sign In')
  end

  scenario 'unauthenticated cannot delete acount' do
    visit root_path

    expect(page).to_not have_content('Account')
    expect(page).to_not have_content('Sign Out')
  end
end
