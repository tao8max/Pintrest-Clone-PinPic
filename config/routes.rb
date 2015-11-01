Rails.application.routes.draw do
  resources :pins

  root to: "pins#index"
end
