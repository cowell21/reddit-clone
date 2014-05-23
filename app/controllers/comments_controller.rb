class CommentsController < ApplicationController

  def new
    render :new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    #isn't required yet "parent_id"

    if @comment.save
      redirect_to post_comments_url(@post)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to new_link_comment_url(params[:link_id])
    end

  end

  def show
    @comment = Comment.find_by_id(params[:id])
    #
    # if @comment
    #   render :show
    # else
    #   redirect_to root_url #was subs_url
    # end
  end

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
  end

  def destroy

    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to post_comments_url(comment.post)
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end

end
