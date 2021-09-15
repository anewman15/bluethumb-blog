class PostsController < ApplicationController
  def index
    response = JSON.parse HTTParty.get('http://localhost:4000/posts').body
    @posts = response['posts']
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
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  private

  def post_params
    params.fetch(:post, {})
  end
end
