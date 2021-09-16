class PagesController < ApplicationController
  def home
    @post = {}
    begin
      response = HTTParty.get('http://localhost:4000/posts')
      @post = JSON.parse(response.body)['posts'].first if response && response.code == 200
    rescue StandardError
      render template: 'pages/server_error'
    end
  end
end
