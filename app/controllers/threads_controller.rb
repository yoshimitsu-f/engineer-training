class ThreadsController < ApplicationController
  before_action :authenticate_user!, {only: [:new, :create, :destroy, :edit, :update]}

  def index
     @posts = Post.all.order(created_at: :desc)
  end

  def new
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def create
    @post = Post.new(content: params[:content])
    @post.save
    redirect_to('/threads/index')
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    @post.save
    redirect_to('/threads/index')
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to('/threads/index')
  end
end
