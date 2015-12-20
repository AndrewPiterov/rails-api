require 'test_helper'

class CreatingBooksTest < ActionDispatch::IntegrationTest
  test 'creates books with valid data' do
    post '/api/books', {
        book: {
            title: 'Cooking Bananas',
            rating: 3,
            author: 'Dave Thomas',
            genre_id: 1,
            amazon_id: 'awer342',
            review: 'not MUST read.'
        }
    }.to_json, {
             'Accept' => 'application/json',
             'Content-Type' => 'application/json'
         }

    assert_equal 201, response.status
    book = json(response.body)[:book]
    assert_equal api_book_url(book[:id]), response.location
    assert_equal 'Cooking Bananas', book[:title]
    assert_equal 3, book[:rating].to_i
    assert_equal 'Dave Thomas', book[:author]
    assert_equal 1, book[:genre_id].to_i
    assert_equal 'awer342', book[:amazon_id]
    assert_equal 'not MUST read.', book[:review]
  end

  test 'does not create books with invalid data' do
    post '/api/books', {
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
