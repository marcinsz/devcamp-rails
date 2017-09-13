class TopicsController < ApplicationController
  before_action :set_sidebar_topics
  layout 'blog'

  def index
    @topics = Topic.all.page(params[:page]).per(5)
  end

  def show
    @topic = Topic.find(params[:id])
    @blogs =  logged_in?(:site_admin)? @topic.blogs.recent.page(params[:page]).per(5) : @topic.blogs.recent.published.page(params[:page]).per(5) 

  end

  private

  def set_sidebar_topics
    @sidebar_topics = Topic.with_blogs
  end
end
