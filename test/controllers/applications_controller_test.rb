require "test_helper"

class ApplicationsControllerTest < ActionDispatch::IntegrationTest
  test 'should return text in sign' do
    post '/sign', params: {text: "Thought you might be interested in {url} {title}. "}, as: :json
    @response = JSON.parse(response.body)
    assert_equal @response['text'], "Thought you might be interested in {url} {title}. "
  end

  test 'should return signed as signature' do
    post '/sign', params: {text: "Thought you might be interested in"}, as: :json
    @response = JSON.parse(response.body)
    assert_equal @response['signed'], "-----BEGIN PGP SIGNED MESSAGE-----\nHash: SHA256\n\nThought you might be interested in\n-----BEGIN PGP SIGNATURE-----\n\niQIzBAEBCAAdFiEENROx5p50mTOovE9CwtUpwKaR7fcFAmBulHsACgkQwtUpwKaR\n7fcedg//fSq1HpIPOAn1TYPhxqzAod5S0eyO8ISCNKv4NyfaulgEBj7ZIoXPu8j7\nfNQB+159nX782IzS23hLHbf5gW9Ced0xSoyYPC2VQR8KS/oI2qQD7PefKKVsL22Q\nzGdwJkQ6GA4hD+VxxuBQRZvutnrf1I1q6lofHsFpWxbO8T68wjh/gPy7vAwXapdP\nEnc7Xz8gW4xPjcedcJa4tDWYPeYFYg691cgrJFpZUnIEMabGbXGRlaxyxXZHTSrq\n57LXOuX0ZKb+XWDnmlXiPeR+5NairmKFNqZTkyrqETua9CsuMUzJO92rXfV16DD9\npQmaYsnBasobZ9NntrM+G5u2MnewY0Z+VL4GAnO++19KN+Hynj5tMXw8oEWtwg5D\n8YpaipjyAkOOBOI0ykqJ82OSc2ux2s1XxWoFPJviIeuOlVw53R+TLR6c8hbaq/OJ\nTeEg+eZTIBRSszL99p+qY8IthENlYtQwu1LXHV/aGhtV4q+3tUIEWx4Y3gnkrz0k\nwWxOb+zziUA4wPI8TrzhQ9JF2ZTFaN4Pwy71HKvEtNt/SWPlR9p01hfRmvZPhSDW\nFeExOTL4a+tT+y4yyHS7tREkfQ0DqxtQ7KnA7emXvv1I4CzfnZ04ShuyBFGDkWsA\ns1F2MZOXi4WvRFID1oLYxfEw8fc3LtKIQTrnVlO/E+NBb+J7quA=\n=dddQ\n-----END PGP SIGNATURE-----\n"
  end

  test 'should return email with key' do
    get '/key', params: {email: 'linus@example.com' }
    @response = JSON.parse(response.body)
    assert_equal @response['email'], 'linus@example.com'
  end

  test 'should return key with key' do
    get '/key', params: {email: 'linus@example.com' }
    @response = JSON.parse(response.body)
    assert @response['pk'].start_with? '-----BEGIN PGP PUBLIC KEY BLOCK-----' and @response['pk'].end_with '-----END PGP PUBLIC KEY BLOCK-----'
  end

  test 'verify should return boolean' do
    post '/verify', params: {text: "-----BEGIN PGP SIGNED MESSAGE-----\nHash: SHA256\n\nhello world\n-----BEGIN PGP SIGNATURE-----\n\niQIzBAEBCAAdFiEENROx5p50mTOovE9CwtUpwKaR7fcFAmBtVGkACgkQwtUpwKaR\n7fdvvA//QkhdQU2ozX5JzOn3ABJNNEGa4sWwdMbb1HX0jGIo30kqTFi44FJXPqUi\nwPKu7l2TTBsjt/QkBRijdiOPYP13n7QyIY43Ahgs3sn+hmjZCaL+MSEWIyFWvPyO\nLfurTNK2nTfNYAsrM41FywAqr8ljnOmdmwfVTTyn4lOe96bhX+qbnSz/Mi1QqexU\n1P0PHnEQZvGtJN5SCWN9XP5frlbF0vTKhkwfA909CgwwVbc5r2z1h8p6pUyaqFBd\n3Xs8tggw7aIDtArv3yTfTDJIxt5J9I4kiEfI1RSZYwj+yB1OvxkD8LjF1UH4fmVx\n8xsDAZxXWd4BywL6jiXweQ2x45dUn+xUPZ8qhhhc8XEljKVLzSGhXtTJHEipSEaY\nHj6A+6W8EwRigQAUiC5oGldrCPcBjHZr97XgOMZxS9FqmGElAEgs5ZCaefkWua6u\ncDb235RX6N8V0mVc393vl2N5d83sHkEbGg1wFFAT19PwS1DU8DreaisXyRzR5LPc\njSjxcutcLNqS8TnzBQXsANL5fN1pZQt12zKkCZ84M6Z4j7ph/w9oOj8vlOHBGxko\nUvuS0wVzSe34Z0MzpRf5qTv4stc+hfUyVJV7v6aiU6clFugMgWlW/bLtawBGchdG\nyOFXUABJIjGPzb2uTEFe3Np8TiBTKyDwv38I56G4AtYSIJ57U/w=\n=IIKm\n-----END PGP SIGNATURE-----\n", key: "-----BEGIN\nPGP\nPRIVATE\nKEY\nBLOCK-----\n\n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\nYxFpK50fwPcXh/qJj5A=\n=ye4x\n-----END\nPGP\nPRIVATE\nKEY\nBLOCK-----\n"}
    assert_true @response.truthy? or @response.falsey?
  end
end
