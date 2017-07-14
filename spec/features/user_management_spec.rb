require "rails_helper"

RSpec.feature "User Management", :type => :feature do
  # These methods should be in a helper file
  def register_confirmed_user
    @user = FactoryGirl.create(:user)
    @user.confirmed_at = Time.zone.now
    @user.save
  end

  def sign_in_user
    fill_in "Email", with: "example_1@email.com"
    fill_in "Password", with: "foobar"
    check "Remember me"
    click_button "Sign in"
  end

  # User account creation
  scenario "User creates a new account" do
    visit "/users/sign_up"

    fill_in "Email", with: "new_account@email.com"
    fill_in "Password", with: "foobar"
    fill_in "Password confirmation", with: "foobar"
    click_button "Sign up"

    # Prompt to check emails
    expect(page).to have_text("A message with a confirmation link has been sent to your email address. Please open the link to activate your account.")
  end

  # User sign in pre-account confirmation
  scenario "User tries to sign in before confirming account" do
    user = FactoryGirl.create(:user) # Unconfirmed
    visit "users/sign_in"

    sign_in_user

    expect(page).to have_text("You have to confirm your account before continuing.")
  end

  # User sign in
  scenario "User signs in" do
    register_confirmed_user
    visit "users/sign_in"

    sign_in_user

    expect(page).to have_text("Signed in successfully.")
  end

  # Incorrect username or password
  scenario "User attempts to sign in with incorrect username or password" do
    visit "users/sign_in"

    fill_in "Email", with: "example_1@email.com"
    fill_in "Password", with: "foobart"
    check "Remember me"
    click_button "Sign in"

    expect(page).to have_text("Invalid email or password.")
  end

  # User logout
  scenario "User logs out" do
    register_confirmed_user
    visit "users/sign_in"
    sign_in_user

    click_link "Log out"

    expect(page).to have_text("Signed out successfully.")
  end
end