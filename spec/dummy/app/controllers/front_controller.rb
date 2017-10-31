class FrontController < ::ApplicationController
  def index
    ::ApplicationJob.new.enqueue(wait: 5.seconds)
    render 'front/index'
  end
end
