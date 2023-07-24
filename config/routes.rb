Rails.application.routes.draw do
  resources :vipr_reviews
  resources :notifications
  resources :depts
  resources :products
  resources :vipr_reports
  resources :viprs
  get 'setType' => 'viprs#setType'
  get '/CopyFromPO'  => 'viprs#CopyFromPO', as: 'CopyFromPO', :defaults => { :format => 'js' }
  get '/SetLineValueVIPR'  => 'viprs#SetLineValueVIPR', as: 'SetLineValueVIPR', :defaults => { :format => 'js' }


  #get "/fetch_items" => 'items#from_category', as: 'CopyFromPO'



  resources :po_approvals
  resources :po_reports
  resources :pr_reports 
  resources :pr_approvals
  get 'getGroup' => 'pr_approvals#getGroup'
  
  resources :purchase_orders
  get 'getPO' => 'purchase_orders#getPO'
  #get 'SetLineValue' => 'purchase_orders#SetLineValue'
  get '/SetLineValue'  => 'purchase_orders#SetLineValue', as: 'SetLineValue', :defaults => { :format => 'js' }
  

  resources :authorizations
  resources :expenses
  get 'getExpense' => 'expenses#getExpense'

  resources :purchase_requests
  resources :suppliers
  get 'getsupplierinfo' => 'suppliers#getsupplierinfo'


  resources :departments
  resources :costcenters
  resources :currencies
  
  
  
 
   #devise_for :users
   
   #get 'user', action: :show, controller: 'users'
   #get 'user', action: :index, controller: 'users'

   
   devise_for :users, :skip => [:registrations], controllers: { sessions: 'user/sessions', passwords: 'user/passwords', confirmations: 'user/confirmations', invitations: 'user/invitations'  }
as :user do
  get 'users/registrations/edit' => 'users/registrations#edit', :as => 'edit_user_registration'    
  #put 'users' => 'devise/registrations#update', :as => 'user_registration'            
end

   #get '/profile', to: 'users#show'
#match 'users/:id' => 'users#show', via: :get

resources :users, only: [:show,:index,:edit,:update], controller: 'users'



   root 'home#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
