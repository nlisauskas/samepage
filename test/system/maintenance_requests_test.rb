require "application_system_test_case"

class MaintenanceRequestsTest < ApplicationSystemTestCase
  setup do
    @maintenance_request = maintenance_requests(:one)
  end

  test "visiting the index" do
    visit maintenance_requests_url
    assert_selector "h1", text: "Maintenance Requests"
  end

  test "creating a Maintenance request" do
    visit maintenance_requests_url
    click_on "New Maintenance Request"

    fill_in "Category", with: @maintenance_request.category
    fill_in "Description", with: @maintenance_request.description
    fill_in "Property", with: @maintenance_request.property_id
    fill_in "Tenant", with: @maintenance_request.tenant_id
    fill_in "Title", with: @maintenance_request.title
    fill_in "User", with: @maintenance_request.user_id
    click_on "Create Maintenance request"

    assert_text "Maintenance request was successfully created"
    click_on "Back"
  end

  test "updating a Maintenance request" do
    visit maintenance_requests_url
    click_on "Edit", match: :first

    fill_in "Category", with: @maintenance_request.category
    fill_in "Description", with: @maintenance_request.description
    fill_in "Property", with: @maintenance_request.property_id
    fill_in "Tenant", with: @maintenance_request.tenant_id
    fill_in "Title", with: @maintenance_request.title
    fill_in "User", with: @maintenance_request.user_id
    click_on "Update Maintenance request"

    assert_text "Maintenance request was successfully updated"
    click_on "Back"
  end

  test "destroying a Maintenance request" do
    visit maintenance_requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Maintenance request was successfully destroyed"
  end
end
