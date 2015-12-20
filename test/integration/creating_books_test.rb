require 'test_helper'

class CreatingBooksTest < ActionDispatch::IntegrationTest
  test 'creates books with valid data' do
    post '/books', {
             book: {
               title: 'Cooking Bananas',
              rating: 3
          }
       }.to_json, {
             'Accept' => 'application/json',
             'Content-Type' => 'application/json'
       }

    assert_equal 201, response.status
    book = json(response.body)
    assert_equal book_url(book[:id]), response.location
    assert_equal 'Cooking Bananas', book[:title]
    assert_equal 3, book[:rating].to_i
  end

  test 'does not create books with invalid data' do
    post '/books', {
        book: {
            title: nil,
            rating: 3
        }
    }.to_json, {
             'Accept' => 'application/json',
             'Content-Type' => 'application/json'
         }

    assert_equal 422, response.status
  end

end
