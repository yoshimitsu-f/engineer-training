class PostsController < ApplicationController
  before_action :authenticate_user!, { only: [:new, :create, :destroy, :edit, :update] }
  before_action :ensure_correct_user, { only: [:edit, :update, :destroy] }


  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != current_user.id
      redirect_to posts_path, alert: "you are not correct_user"
    end
  end

  def index
     @posts = Post.all.order(created_at: :desc)
  end

  def new
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
  end

  def create
    @post = Post.new(content: params[:content], user_id: current_user.id)
    if @post.save
      redirect_to('/posts')
    else
      redirect_to new_post_path, alert: "content can't be blank"
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      redirect_to('/posts')
    else
      redirect_to edit_post_path, alert: "content can't be blank"
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to('/posts')
  end
end
