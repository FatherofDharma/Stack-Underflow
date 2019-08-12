class TopicsController < ApplicationController
  before_action :authorize, only: [:new, :show, :destroy]

  def index
    @topics = Topic.all
    render :index
  end

  def new
    @topics = Topic.all
    @topic = Topic.new
    render :new
  end

  def create
    @user = User.find_by_id(session[:user_id])
    @topic = @user.topics.new(topic_params)
    binding.pry
    if @topic.save
      flash[:notice] = {:content => "You've created a topic!", :class => "alert alert-success"}
      redirect_to topic_path(@topic)
    else
      flash[:alert] = {:content => "Whoops! There was an error", :class => "alert alert-danger"}
      redirect_to new_topic_path
    end
  end

  def topic_params
    params.require(:topic).permit(:title)
  end

  def show
    id = params[:id]
    @topic = Topic.find_by_id(id)
    @posts = @topic.posts
    @users = []
    @posts.each do |p|
      user = User.all.where(id: p.user_id).first
      if @users.include?(user) == false
        @users.push(user)
      end

    end
    render :topic
  end

  def destroy
    id = params[:id]
    @topic = Topic.find_by_id(id)
    @posts = @topic.posts
    @posts.destroy_all
    @topic.destroy
    redirect_to topics_path
  end

end
