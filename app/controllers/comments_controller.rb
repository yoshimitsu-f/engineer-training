class CommentsController < ApplicationController
  before_action :authenticate_user!, { only: [:new, :create, :destroy, :edit, :update] }
  before_action :ensure_correct_user, { only: [:edit, :update, :destroy] }

  def ensure_correct_user
    @comment = Comment.find_by(id: params[:id])
    if @comment.user_id != current_user.id
      redirect_to posts_path, alert: "you are not correct_user"
    end
  end


  def index
   @post = Post.find_by(id:params[:post_id])
  end

  def new
    @comment = Comment.new(body: params[:body], post_id: params[:post_id])
  end

  def create
    @comment = Comment.new(body: params[:body], post_id: params[:post_id], user_id: current_user.id)
    if @comment.save
      redirect_to(post_comments_path)
    else
      redirect_to new_post_comment_path, alert: "body can't be blank"
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    redirect_to(post_comments_path)
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
  end

  def update
    @comment = Comment.find_by(id: params[:id])
    @comment.body = params[:body]
    if @comment.save
      redirect_to(post_comments_path)
    else
      redirect_to edit_post_comment_path, alert: "body can't be blank"
    end
  end
end
