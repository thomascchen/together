require 'rails_helper'

feature 'user views profile', %{
  As an authenticated user,
  I can view individual profiles,
  So I can learn about individuals who live in my building
} do

  # Acceptance Criteria
  # [x] User can view another user's profile
  # [x] User must be authenticated to view profiles
  # [ ] User profile should display name, email address, building, apartment
  #     number, neighborhood, and user contributions, and user photograph,
  #     time when the user profile was created, time last active, and message
  #     if user has no activity

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
  let(:user) do
    FactoryGirl.create(:user, building: building, neighborhood: allston)
  end

  scenario 'authenticated user views profile' do
    sign_in(user)
    visit user_path(user)

    expect(page).to have_content(user.name)
    # expect(page).to have_link("Edit Profile")
    expect(page).to have_content(user.building.street)
    expect(page).to have_content("Apartment #{user.unit}")
    expect(page).to have_content(
      "#{user.neighborhood.name}, #{user.building.state}"
    )
    expect(page).to have_content("#{user.first_name} has no activity")
    expect(page).to have_content(
      "Member since #{user.created_at.strftime('%B %e, %Y')}"
    )
  end

  scenario 'unauthenticated user cannot view profile' do
    visit user_path(user)

    expect(page).to_not have_content(user.name)
    expect(page).to_not have_link(
      "Contact #{user.first_name}", href: "mailto:#{user.email}"
    )
    expect(page).to_not have_content(user.building.street)
    expect(page).to_not have_content("Apartment #{user.unit}")
    expect(page).to_not have_content(
      "#{user.neighborhood.name}, #{user.building.state}"
    )
    expect(page).to_not have_content("#{user.first_name} has no activity")
    expect(page).to_not have_content(
      "Member since #{user.created_at.strftime('%B %e, %Y')}"
    )
  end

  pending 'user can view photo and data visualization'
end
