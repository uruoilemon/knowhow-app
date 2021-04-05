class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  def index
   @posts = Post.all.order(created_at: :desc)
  end
  
  def new
    @posts_tag = PostsTag.new
  end
  
  def create
    @posts_tag = PostsTag.new(post_params)
    if @posts_tag.save
       redirect_to posts_path, notice: 'The post has been created.'
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @tag = @post.tags
  end
  
  def edit
    @post = current_user.posts.find(params[:id])
    @posts_tag = PostsTag.new(post: @post)
  end

  def update
    load_post
    @posts_tag = PostsTag.new(post_params, post: @post)
    if @posts_tag.save
       redirect_to @post, notice: 'The post has been updated.'
    else
      render :edit
    end
  end

  def destroy
    posts_tag = PostsTag.find(params[:id])
    posts_tag.destroy
    redirect_to root_path
  end


  def tag_search
    return nil if params[:keyword] == ""
    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end
  def search
    @posts = Post.search(params[:keyword])
  end

private
  def post_params
    params.require(:post).permit(:title, :text, :answer, :image, :tag_names).merge(user_id: current_user.id)
  end
 
  def load_post
    @post = current_user.posts.find(params[:id])
  end
end
