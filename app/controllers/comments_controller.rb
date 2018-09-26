class CommentsController < ApplicationController
  before_action :authenticate_user!, {only: [:new, :create, :destroy, :edit, :update]}

  def index
@post = Post.find_by(params[:post_id])
@comments = Comment.where(post_id: params[:post_id])
  end

  def new
    @post = Post.find_by(id: params[:id])
    @comment = Comment.new(body: params[:body], post_id: params[:post_id])
  end

  def create
    @post = Post.find_by(params[:post_id])
    @comment = Comment.new(body: params[:body], post_id: params[:post_id])
    @comment.save
    redirect_to("/threads/index")
  end

  def destroy
    @post = Post.find_by(params[:post_id])
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    redirect_to("/threads/index")
  end

  def edit
    @post = Post.find_by(params[:post_id])
    @comment = Comment.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(params[:post_id])
    @comment = Comment.find_by(id: params[:id])
    @comment.body = params[:body]
    @comment.save
    redirect_to("/threads/index")
  end
end
