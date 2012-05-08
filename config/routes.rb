GetAJob::Application.routes.draw do
  get "/profile" => "profile#show"
  root :to => "jobs#new"

  resources :jobs, except: :edit
end
