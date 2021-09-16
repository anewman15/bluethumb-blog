class PostsController < ApplicationController
  def index
    @posts = []
    begin
      response = HTTParty.get('http://localhost:4000/posts')
      posts = JSON.parse(response.body)['posts'] if response && response.code == 200
      @posts = posts.reverse
    rescue StandardError
      redirect_to root_path, error: 'Something went wrong.'
    end
  end

  def show
    @post = {}
    @comment = Comment.new
    begin
      post_response = HTTParty.get("http://localhost:4000/posts/#{params[:id]}")
      comments_response = HTTParty.get("http://localhost:4000/posts/#{params[:id]}/comments")

      if post_response && comments_response && post_response.code == 200 && comments_response.code == 200
        @post = JSON.parse(post_response.body)
        @comments = JSON.parse(comments_response.body)['comments']
      end
    rescue StandardError
      redirect_to root_path, error: 'Something went wrong.'
    end
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
