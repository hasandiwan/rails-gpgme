require "test_helper"

class ApplicationsControllerTest < ActionDispatch::IntegrationTest
  test 'should return signature' do
    post '/sign', params: {text: "Thought you might be interested in {url} {title}. "}, as: :json
    #binding.pry
    assert_equal @response.code, :created
    assert_equal @response.body[:text], "Thought you might be interested in {url} {title}. "
    assert_equal @response.body[:signed], "-----BEGIN PGP SIGNED MESSAGE-----\nHash: SHA256\n\nhello world\n-----BEGIN PGP SIGNATURE-----\n\niQIzBAEBCAAdFiEENROx5p50mTOovE9CwtUpwKaR7fcFAmBtVGkACgkQwtUpwKaR\n7fdvvA//QkhdQU2ozX5JzOn3ABJNNEGa4sWwdMbb1HX0jGIo30kqTFi44FJXPqUi\nwPKu7l2TTBsjt/QkBRijdiOPYP13n7QyIY43Ahgs3sn+hmjZCaL+MSEWIyFWvPyO\nLfurTNK2nTfNYAsrM41FywAqr8ljnOmdmwfVTTyn4lOe96bhX+qbnSz/Mi1QqexU\n1P0PHnEQZvGtJN5SCWN9XP5frlbF0vTKhkwfA909CgwwVbc5r2z1h8p6pUyaqFBd\n3Xs8tggw7aIDtArv3yTfTDJIxt5J9I4kiEfI1RSZYwj+yB1OvxkD8LjF1UH4fmVx\n8xsDAZxXWd4BywL6jiXweQ2x45dUn+xUPZ8qhhhc8XEljKVLzSGhXtTJHEipSEaY\nHj6A+6W8EwRigQAUiC5oGldrCPcBjHZr97XgOMZxS9FqmGElAEgs5ZCaefkWua6u\ncDb235RX6N8V0mVc393vl2N5d83sHkEbGg1wFFAT19PwS1DU8DreaisXyRzR5LPc\njSjxcutcLNqS8TnzBQXsANL5fN1pZQt12zKkCZ84M6Z4j7ph/w9oOj8vlOHBGxko\nUvuS0wVzSe34Z0MzpRf5qTv4stc+hfUyVJV7v6aiU6clFugMgWlW/bLtawBGchdG\nyOFXUABJIjGPzb2uTEFe3Np8TiBTKyDwv38I56G4AtYSIJ57U/w=\n=IIKm\n-----END PGP SIGNATURE-----\n"
  end
#  test "should get index" do
#    get applications_url, as: :json
#    assert_response :success
#  end
#
#  test "should create application" do
#    assert_difference('Application.count') do
#      post applications_url, params: { application: {  } }, as: :json
#    end
#
#    assert_response 201
#  end
#
#  test "should show application" do
#    get application_url(@application), as: :json
#    assert_response :success
#  end
#
#  test "should update application" do
#    patch application_url(@application), params: { application: {  } }, as: :json
#    assert_response 200
#  end
#
#  test "should destroy application" do
#    assert_difference('Application.count', -1) do
#      delete application_url(@application), as: :json
#    end
#
#    assert_response 204
#  end
end
