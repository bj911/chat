Chat::Application.routes.draw do

  devise_for :admins, :controllers => { :sessions => "admins/sessions" }
  devise_for :users

  resources :chat
  resources :anketa
  match "/i_am_online" => "chat#i_am_online"
  root :to => "chat#index"
end