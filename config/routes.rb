GetAJob::Application.routes.draw do
  root "jobs#index"

  resources :jobs
  get "/profile" => "profile#show"
end
