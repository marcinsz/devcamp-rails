class TopicsController < ApplicationController
  layout 'blog'

  def index
    @topics = Topic.all.page(params[:page]).per(5)
  end

  def show
    @topic = Topic.find(params[:id])
    @blogs =  logged_in?(:site_admin)? @topic.blogs.recent.page(params[:page]).per(5) : @topic.blogs.recent.published.page(params[:page]).per(5) 

  end
end
