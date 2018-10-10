# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :ensure_correct_user, only: %i[index show create]

  def index
    @posts = Post.all.order(created_at: :desc)
    @posts = Post.page(params[:page]).per(10)
  end

  def new; end

  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(params[:post_id])
  end

  def create
    @post = Post.new(content: params[:content], user_id: current_user.id)
    if @post.save
      redirect_to posts_path
    else
      redirect_to new_post_path, alert: "content can't be blank"
    end
  end

  def edit; end

  def update
    @post.content = params[:content]
    if @post.save
      redirect_to posts_path
    else
      redirect_to edit_post_path, alert: "content can't be blank"
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path
    else
      redirect_to post_path, alert: 'failed delete'
    end
  end

  private

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != current_user.id
      redirect_to posts_path, alert: 'you are not correct_user'
    end
  end
end
