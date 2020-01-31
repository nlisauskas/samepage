require "application_system_test_case"

class ContractorsTest < ApplicationSystemTestCase
  setup do
    @contractor = contractors(:one)
  end

  test "visiting the index" do
    visit contractors_url
    assert_selector "h1", text: "Contractors"
  end

  test "creating a Contractor" do
    visit contractors_url
    click_on "New Contractor"

    fill_in "Company", with: @contractor.company
    fill_in "Email", with: @contractor.email
    fill_in "First name", with: @contractor.first_name
    fill_in "Last name", with: @contractor.last_name
    fill_in "Maintenance request", with: @contractor.maintenance_request_id
    fill_in "Password digest", with: @contractor.password_digest
    fill_in "Phone", with: @contractor.phone
    click_on "Create Contractor"

    assert_text "Contractor was successfully created"
    click_on "Back"
  end

  test "updating a Contractor" do
    visit contractors_url
    click_on "Edit", match: :first

    fill_in "Company", with: @contractor.company
    fill_in "Email", with: @contractor.email
    fill_in "First name", with: @contractor.first_name
    fill_in "Last name", with: @contractor.last_name
    fill_in "Maintenance request", with: @contractor.maintenance_request_id
    fill_in "Password digest", with: @contractor.password_digest
    fill_in "Phone", with: @contractor.phone
    click_on "Update Contractor"

    assert_text "Contractor was successfully updated"
    click_on "Back"
  end

  test "destroying a Contractor" do
    visit contractors_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Contractor was successfully destroyed"
  end
end
