class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)

    if @comment.valid?
      begin
        response = HTTParty.post("#{@@host}/posts/#{params[:post_id]}/comments", comment_options)
        if response && response.code == 201
          @comment = JSON.parse(response.body)['comment']
          redirect_to post_path(params[:post_id]), success: 'Comment added.'
        end
      rescue StandardError
        redirect_to post_path(params[:post_id]), error: 'Something went wrong. Please try again.'
      end
    else
      redirect_to post_path(params[:post_id]), error: comment_error
    end
  end

  private

  def comment_error
    message = ''
    @comment.errors.full_messages.each do |m|
      message += "---#{m}\n"
    end
    message
  end

  def comment_options
    {
      body: {
        comment: {
          name: comment_params[:name],
          body: comment_params[:body]
        }
      }
    }
  end

  def comment_params
    params.require(:comment).permit(:post_id, :name, :body)
  end
end
