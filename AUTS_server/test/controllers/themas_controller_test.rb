require 'test_helper'

class ThemasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @thema = themas(:one)
  end

  test "should get index" do
    get themas_url, as: :json
    assert_response :success
  end

  test "should create thema" do
    assert_difference('Thema.count') do
      post themas_url, params: { thema: { name: @thema.name, teacher_id: @thema.teacher_id } }, as: :json
    end

    assert_response 201
  end

  test "should show thema" do
    get thema_url(@thema), as: :json
    assert_response :success
  end

  test "should update thema" do
    patch thema_url(@thema), params: { thema: { name: @thema.name, teacher_id: @thema.teacher_id } }, as: :json
    assert_response 200
  end

  test "should destroy thema" do
    assert_difference('Thema.count', -1) do
      delete thema_url(@thema), as: :json
    end

    assert_response 204
  end
end
