Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/administration', as: 'rails_admin'
  resources :requests
  get 'controle/sobre'
  get 'controle/home'
  get 'sign' => 'requests#sign'
  get 'refuse' => 'requests#refuse'
  

  devise_for :admins, :skip => [:registrations]
  devise_for :users, :skip => [:registrations] 



  as :user do
    get 'users/edit' => 'users/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'users/registrations#update', :as => 'user_registration'
    root :to => "devise/sessions#new"
  end



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
