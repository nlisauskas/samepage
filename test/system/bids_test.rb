require "application_system_test_case"

class BidsTest < ApplicationSystemTestCase
  setup do
    @bid = bids(:one)
  end

  test "visiting the index" do
    visit bids_url
    assert_selector "h1", text: "Bids"
  end

  test "creating a Bid" do
    visit bids_url
    click_on "New Bid"

    check "Approved" if @bid.approved
    fill_in "Availability", with: @bid.availability
    fill_in "Contractor", with: @bid.contractor_id
    fill_in "Maintenance request", with: @bid.maintenance_request_id
    fill_in "Notes", with: @bid.notes
    fill_in "Payout", with: @bid.payout
    fill_in "Price", with: @bid.price
    click_on "Create Bid"

    assert_text "Bid was successfully created"
    click_on "Back"
  end

  test "updating a Bid" do
    visit bids_url
    click_on "Edit", match: :first

    check "Approved" if @bid.approved
    fill_in "Availability", with: @bid.availability
    fill_in "Contractor", with: @bid.contractor_id
    fill_in "Maintenance request", with: @bid.maintenance_request_id
    fill_in "Notes", with: @bid.notes
    fill_in "Payout", with: @bid.payout
    fill_in "Price", with: @bid.price
    click_on "Update Bid"

    assert_text "Bid was successfully updated"
    click_on "Back"
  end

  test "destroying a Bid" do
    visit bids_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bid was successfully destroyed"
  end
end
