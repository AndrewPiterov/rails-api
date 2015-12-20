class GenresController< ApplicationController
  def index
    render json: Genre.all, response: 200
  end
end