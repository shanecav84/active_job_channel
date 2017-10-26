Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # mount Pendant::Engine => '/cable/pendant'
  get '/', controller: :front, action: :index, as: :root
end
