class PostsController < ApplicationController

  def index
    if params[:author_id]
      @posts = Author.find(params[:author_id]).posts
    else
      @posts = Post.all
    end
  end

  def show
    if params[:author_id]
      @post = Author.find(params[:author_id]).posts.find(params[:id])
    else
      @post = Post.find(params[:id])
    end
  end


  def new
    if params[:author_id] && !Author.exists?(params[:author_id])
      redirect_to authors_path, alert: "Author not found."
    # (2) After setting up the route, we need to update the controller action to handle the :author_id parameter.
    @post = Post.new(author_id: params[:author_id])
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end 

  def edit
    if params[:author_id]
      author = Author.find_by(id: params[:author_id])
      if author.nil?
        redirect_to authors_path, alert: "Author not found."
      else
        @post = author.posts.find_by(id: params[:id])
        redirect_to author_posts_path(author), alert: "Post not found." if @post.nil?
      end
    else
      @post = Post.find(params[:id])
    end
  end 

  private

  # (5) We should update the strong parameters to accept the :author_id as a parameter for a post 
  def post_params
    params.require(:post).permit(:title, :description, :author_id)
  end

end
