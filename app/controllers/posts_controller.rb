class PostsController < ApplicationController
  def index
    response = JSON.parse HTTParty.get('http://localhost:4000/posts').body
    posts = response['posts']
    @posts = posts.reverse
  end

  def show
    post = JSON.parse HTTParty.get("http://localhost:4000/posts/#{params[:id]}").body
    @post = post
    comments_response = JSON.parse HTTParty.get("http://localhost:4000/posts/#{params[:id]}/comments").body
    @comments = comments_response['comments']
  end

  def new
    @post = 'Post'
  end

  def create
    begin
      response = HTTParty.post("http://localhost:4000/posts", post_options)
      redirect_to posts_path, notice: 'Post created successfully!' if response.code == 201
    rescue StandardError
      render :new
    end
  end

  private

  def post_options
    {
      body: {
        post: {
          title: post_params[:title],
          body: post_params[:body]
        }
      }
    }
  end

  def post_params
    params.require(:Post).permit(:title, :body)
  end
end
