class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to posts_path }
        format.js
      else
        format.html { redirect_to posts_path }
        format.js
      end
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end

end
