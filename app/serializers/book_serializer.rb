class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :rating, :genre_id, :amazon_id, :author, :review
end
