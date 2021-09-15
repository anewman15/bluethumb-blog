class PagesController < ApplicationController
  def home
    response = HTTParty.get('http://localhost:4000/posts')
    @post = JSON.parse(response.body)['posts'].first if response.code == 200
  end
end
