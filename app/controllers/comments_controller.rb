class CommentsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new
    render :new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to post_comments_url(@post)
    else
      flash[:errors] = ["comment body can't be blank"]
      redirect_to post_comments_url(@post)
    end

  end

  def show
    @comment = Comment.find_by_id(params[:id])
  end

  def index
    @post = Post.find(params[:post_id])
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.body = "[comment deleted by #{current_user.username}]"
    comment.save
    redirect_to post_comments_url(comment.post)

    # if you want really destroy instead | uncomment below
    # comment = Comment.find(params[:id])
    # comment.destroy
    # redirect_to post_comments_url(comment.post)
  end

  def upvote
    if current_user

      @comment = Comment.find(params[:id])
      vote(1) if current_user
      redirect_to root_url #failsafe if JS breaks
    else
      flash[:errors] = ["Must be logged in to vote"]
      redirect_to new_session_url
    end
  end

  def downvote
    if current_user

      @comment = Comment.find(params[:id])
      vote(-1) if current_user
      redirect_to root_url #failsafe if JS breaks
    else
      flash[:errors] = ["Must be logged in to vote"]
      redirect_to new_session_url
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end

  def vote(direction)
    @vote = CommentVote.find_by_comment_id_and_user_id(@comment.id, current_user.id)

    if @vote
      @vote.value == direction ? @vote.update_attributes(value: 0) : @vote.update_attributes(value: direction)
    else
      @comment.votes.create(user_id: current_user.id, value: direction)
    end
  end

end
