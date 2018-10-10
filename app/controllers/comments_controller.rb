# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :ensure_correct_user, except: %i[index new create]

  def index
    binding.pry
    @post = Post.find_by(params[:post_id])
    @comments = Comment.page(params[:page]).per(10)
  end

  def new
    @comment = Comment.new
    @post_id = params[:post_id]
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post_id = params[:post_id]
    if @comment.save!
      redirect_to(post_comments_path(params[:post_id]))
    else
      redirect_to new_post_comment_path, alert: "body can't be blank"
    end
  end

  def destroy
    if @comment.destroy
      redirect_to(post_comments_path)
    else
      redirect_to post_comments_path, alert: 'failed delete'
    end
  end

  def edit; end

  def update
    @comment.body = params[:body]
    if @comment.save
      redirect_to(post_comments_path)
    else
      redirect_to edit_post_comment_path, alert: "body can't be blank"
    end
  end

  private

  def ensure_correct_user
    @comment = Comment.find_by(id: params[:id])
    @user = @comment.user
    if @user.mycomment?(@comment)
      redirect_to posts_path, alert: 'you are not correct_user'
    end
  end

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
end
