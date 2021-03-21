class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  def index
   @posts = Post.all.order(created_at: :desc)
  end
  
  def new
    @post = PostsTag.new
  end
  
  def create
    @post = PostsTag.new(post_params)
    if @post.valid?
       @post.save
       redirect_to root_path
    else
      render :new
    end
  end

  def tag_search
    return nil if params[:keyword] == ""
    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end
  def search
    @posts = Post.search(params[:keyword])
  end

  def post_params
    params.require(:posts_tag).permit(:title, :text, :answer, :image, :name).merge(user_id: current_user.id)
  end
end
