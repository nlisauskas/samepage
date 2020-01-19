require "application_system_test_case"

class TenantsTest < ApplicationSystemTestCase
  setup do
    @tenant = tenants(:one)
  end

  test "visiting the index" do
    visit tenants_url
    assert_selector "h1", text: "Tenants"
  end

  test "creating a Tenant" do
    visit tenants_url
    click_on "New Tenant"

    fill_in "Birthdate", with: @tenant.birthdate
    fill_in "Email", with: @tenant.email
    fill_in "First name", with: @tenant.first_name
    fill_in "Gender", with: @tenant.gender
    fill_in "Last name", with: @tenant.last_name
    fill_in "Password digest", with: @tenant.password_digest
    fill_in "Property", with: @tenant.property_id
    fill_in "User", with: @tenant.user_id
    click_on "Create Tenant"

    assert_text "Tenant was successfully created"
    click_on "Back"
  end

  test "updating a Tenant" do
    visit tenants_url
    click_on "Edit", match: :first

    fill_in "Birthdate", with: @tenant.birthdate
    fill_in "Email", with: @tenant.email
    fill_in "First name", with: @tenant.first_name
    fill_in "Gender", with: @tenant.gender
    fill_in "Last name", with: @tenant.last_name
    fill_in "Password digest", with: @tenant.password_digest
    fill_in "Property", with: @tenant.property_id
    fill_in "User", with: @tenant.user_id
    click_on "Update Tenant"

    assert_text "Tenant was successfully updated"
    click_on "Back"
  end

  test "destroying a Tenant" do
    visit tenants_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tenant was successfully destroyed"
  end
end
