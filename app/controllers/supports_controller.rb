class SupportsController < ApplicationController

  expose_decorated(:topic){ Topic.find(params[:topic_id]) }
  expose_decorated(:support) { Support.find(params[:id]) }
  expose_decorated(:comments){ support.comments.includes(:user) }

  def create
    need_support = AskForSupport.new(current_user.object, topic, params[:support])
    need_support.commence!
    redirect_to topics_path, notice: "We asked #{need_support.supporter} to help you."
  end


  def finish
    support_finish = FinishSupport.new(current_user.object, support)
    support_finish.commence!
    redirect_to root_path, notice: "Finished helping. Awesome!"
  end

end
