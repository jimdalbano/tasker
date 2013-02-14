Tasker::Application.routes.draw do
  root :to => 'welcome#index'
  resources :tasks
  # match "/tasks(.:format)" => "tasks#index", :via => :get, :as => :tasks
  # match "/tasks(.:format)" => "tasks#create", :via => :post

  # match "/tasks/:id(.:format)" => "tasks#show", :via => :get, :as => :task
  # match "/tasks/:id(.:format)" => "tasks#update", :via => [:post, :put, :patch]

  # this needs to change!
  # match "/tasks/:id(.:format)" => "tasks#delete", :via => [:delete]
end
