require 'test_helper'

class EventControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get event_index_url
    assert_response :success
  end

  test "should get new" do
    get event_new_url
    assert_response :success
  end

  test "should get create" do
    get event_create_url
    assert_response :success
  end

  test "should get listing" do
    get event_listing_url
    assert_response :success
  end

  test "should get pricing" do
    get event_pricing_url
    assert_response :success
  end

  test "should get description" do
    get event_description_url
    assert_response :success
  end

  test "should get photo_upload" do
    get event_photo_upload_url
    assert_response :success
  end

  test "should get amenities" do
    get event_amenities_url
    assert_response :success
  end

  test "should get location" do
    get event_location_url
    assert_response :success
  end

  test "should get update" do
    get event_update_url
    assert_response :success
  end

end
