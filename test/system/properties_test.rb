require "application_system_test_case"

class PropertiesTest < ApplicationSystemTestCase
  setup do
    @property = properties(:one)
  end

  test "visiting the index" do
    visit properties_url
    assert_selector "h1", text: "Properties"
  end

  test "creating a Property" do
    visit properties_url
    click_on "New Property"

    fill_in "City", with: @property.city
    fill_in "Purchase date", with: @property.purchase_date
    fill_in "Purchase price", with: @property.purchase_price
    fill_in "Sale date", with: @property.sale_date
    fill_in "Sale price", with: @property.sale_price
    fill_in "State", with: @property.state
    fill_in "Street 1", with: @property.street_1
    fill_in "Street 2", with: @property.street_2
    fill_in "Tenant", with: @property.tenant_id
    fill_in "User", with: @property.user_id
    fill_in "Zipcode", with: @property.zipcode
    click_on "Create Property"

    assert_text "Property was successfully created"
    click_on "Back"
  end

  test "updating a Property" do
    visit properties_url
    click_on "Edit", match: :first

    fill_in "City", with: @property.city
    fill_in "Purchase date", with: @property.purchase_date
    fill_in "Purchase price", with: @property.purchase_price
    fill_in "Sale date", with: @property.sale_date
    fill_in "Sale price", with: @property.sale_price
    fill_in "State", with: @property.state
    fill_in "Street 1", with: @property.street_1
    fill_in "Street 2", with: @property.street_2
    fill_in "Tenant", with: @property.tenant_id
    fill_in "User", with: @property.user_id
    fill_in "Zipcode", with: @property.zipcode
    click_on "Update Property"

    assert_text "Property was successfully updated"
    click_on "Back"
  end

  test "destroying a Property" do
    visit properties_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Property was successfully destroyed"
  end
end
