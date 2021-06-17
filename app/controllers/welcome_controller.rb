class WelcomeController < ApplicationController
  def index
    render json: { message: 'Welcome to the Film Search API' }, status: 200
  end
end
