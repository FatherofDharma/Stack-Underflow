class PostsController < ApplicationController
  before_action :authorize, only: [:create]

  def create
    topic_id = params[:topic_id]
    user_id = session[:user_id]
    content_body = params[:content_body]
    @topic = Topic.find_by_id(topic_id)
    @post = @topic.posts.new(:content_body => content_body, :topic_id => topic_id, :user_id => user_id)
    @post.save
    redirect_to topic_path(@topic)
  end

  # def post_params
  #   params.require(:post).permit(:content_body, :user_id)
  # end
end
