class BlogsController < ApplicationController
  before_action :set_blog, only: [:edit, :update, :destroy, :toogle_status]
  before_action :set_sidebar_topics, except: [:update, :create, :destroy, :toogle_status]
  layout "blog"
  
  #petergate authorization configuration
  access all: [:show, :index], user: {except: [:destroy, :new, :create, :edit, :update, :toogle_status ]}, site_admin: :all

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs =  logged_in?(:site_admin)? Blog.recent.page(params[:page]).per(5) : Blog.recent.published.page(params[:page]).per(5) 
    @page_title = "My Blog"
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @blog = Blog.includes(:comments).friendly.find(params[:id])
    if logged_in?(:site_admin) || @blog.published?
      @comment = Comment.new
      @page_title = @blog.title
    else
      redirect_to blogs_url
    end  
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toogle_status
    if @blog.published?
      @blog.draft!
    elsif @blog.draft?
      @blog.published!
    end
    redirect_to blogs_url, notice: "Status was successfully updated"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :body, :topic_id)
    end

    def set_sidebar_topics
      @sidebar_topics = Topic.with_blogs
    end
end
