require 'rails_helper'

feature 'user updates account', %{
  As an authenticated user,
  I can update my account,
  So I can keep my information up to date
} do

  # Acceptance Criteria
  # [ ] User can update their first name, last name, email, password, building,
  #     unit, and neighborhood, and picture
  # [ ] User must be authenticated to update their account information
  # [ ] User is presented with success message after submitting valid
  #     information and taken to problems index
  # [ ] User is presented with error message if submitting invalid information
  #     and update page is re-rendered with prior information filled out
  # [ ] User can also delete account from Update page

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

  let(:user) { FactoryGirl.create(:user, building: building, neighborhood: allston) }

  pending 'authenticated user submits valid information'
  #   sign_in(user)
  #   click_on('Account')
  #   click_on('Edit Profile')
  #   fill_in 'First Name', with: 'Tom'
  #   fill_in 'Last Name', with: 'Chen'
  #   fill_in 'Email', with: 't@t.com'
  #   fill_in 'Apartment Number', with: '10'
  #   fill_in 'Password (Leave blank to keep current password)', with: "newpassword"
  #   fill_in 'Password Confirmation', with: "newpassword"
  #   fill_in "user_current_password", with: 'password'
  #
  #   click_button("Update Profile")
  #
  #   expect(page).to have_content("Your account has been updated successfully.")
  # end

  pending 'authenticated user submits invalid information'
  #   sign_in(user)
  #   click_on('Account')
  #   click_on('Edit Profile')
  #
  #   fill_in 'First Name', with: ' '
  #
  #   click_button("Update Profile")
  #
  #   expect(page).to have_content("can't be blank")
  # end

  scenario 'unauthenticated user cannot update account' do
    visit user_path(user)

    expect(page).to_not have_link("Edit Profile")
  end

  pending 'user updates photo'
  pending 'delete account modal'
end
