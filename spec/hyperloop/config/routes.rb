HyperloopApplication.routes.draw do
  root "todo#index"
  get "/todo/index", to: "todo#index"
  get "/todo/new", to: "todo#new"
  post "/todo/create", to: "todo#create"
  get "/todo/:id/show", to: "todo#show"
  get "/todo/:id/edit", to: "todo#edit"
  put "/todo/update", to: "todo#update"
  delete "/todo/:id/destroy", to: "todo#destroy"
  get "/todo/:todo_id/item/new", to: "items#new"
  post "/todo/:todo_id/item/create", to: "items#create"
end
