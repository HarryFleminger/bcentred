class BlogPostsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  def index
    @blog_posts = BlogPost.all
  end

  def show
    @blog_post = BlogPost.find(params[:id])
    @blog_post.increment!(:views)
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    @blog_post.body = @blog_post.body.strip
    @blog_post.user = current_user
    if @blog_post.save
      redirect_to @blog_post, :notice => "Successfully created blog post."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @blog_post = BlogPost.find(params[:id])
  end

  def update
    @blog_post = BlogPost.find(params[:id])
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post, :notice  => "Successfully updated blog post."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post = BlogPost.find(params[:id])
    @blog_post.destroy
    redirect_to blog_posts_url, :notice => "Successfully destroyed blog post."
  end

  def like
    @blog_post = BlogPost.find(params[:id])
    liked_posts = cookies[:liked_posts].to_s.split(",")

    if liked_posts.include?(@blog_post.id.to_s)
      @blog_post.decrement!(:likes)
      liked_posts.delete(@blog_post.id.to_s)
    else
      @blog_post.increment!(:likes)
      liked_posts << @blog_post.id.to_s
    end

    cookies[:liked_posts] = liked_posts.join(",")

    respond_to do |format|
      format.json { render json: { likes: @blog_post.likes } }
    end
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :body, :photo, :minutes_to_read)
  end
end
