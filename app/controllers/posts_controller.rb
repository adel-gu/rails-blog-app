class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.where(post: @post)
  end

  def new
    @post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: @post } }
    end
  end

  def create
    @post = Post.new(params.require(:post).permit(:title, :text).merge(author: current_user))
    respond_to do |format|
      format.html do
        if @post.save
          flash[:sucess] = 'Post Saved successfully'
          redirect_to user_posts_path(current_user)
        else
          flash.now[:error] = 'Error: Post could not be saved'
          render { render :new, locals: { post: @post } }
        end
      end
    end
  end

  def destroy
    Post.delete(params[:id])
    redirect_to user_posts_path(params[:user_id])
  end
end
