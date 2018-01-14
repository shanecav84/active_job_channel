class FrontController < ::ApplicationController
  def index
    ::ApplicationJob.set(wait: 5.seconds).perform_later('bloop')
    render 'front/index'
  end
end
