class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comments = @post.comments.all.count
    @comment = @post.comments.create(comment_params)

    respond_to do |format|
      if @comment.save
        format.turbo_stream
      else
        format.html { redirect_to posts_path, notice: "Something is wrong." }
      end
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end

end
