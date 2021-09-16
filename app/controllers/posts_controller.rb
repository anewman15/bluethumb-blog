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
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.valid?
      begin
        response = HTTParty.post("http://localhost:4000/posts", post_options)
        if response && response.code == 201
          @post = JSON.parse(response.body)['post']
          redirect_to posts_path, success: 'Post created successfully!'
        end
      rescue StandardError
        redirect_to new_post_path, error: 'Something went wrong. Please try again.'
      end
    else
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
    params.require(:post).permit(:title, :body)
  end
end
