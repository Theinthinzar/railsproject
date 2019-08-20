Rails.application.routes.draw do 
  #yehtetaung start 24/6/2019
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  #yehtetaung end 24/6/2019
  
  #yehtetaung start 26/6/2019
  get '/search', to: 'sessions#search'
  post '/search', to: 'sessions#wsearch'
  #yehtetaung end 1/7/2019
  
  #yehtetaung start 24/6/2019
  root 'static_pages#welcome' 
  #yehtetaung end 24/6/2019

  #yehtetaung start 25/6/2019
  get '/workspacecreate', to: 'static_pages#workspacecreate'
  get '/workspacehome', to: 'static_pages#workspacehome'
  #yehtetaung end 25/6/2019

  #Thinzarthein,SweZinMyat start 24/6/2019
  get '/home', to:'static_pages#home'
  #Thinzarthein,SweZinMyat end 25/6/2019
 
  #SweZinMyat start 5/7/2019
  get '/unread', to: 'static_pages#unread'
  get '/update', to: 'static_pages#update'
  #SweZinMyat end 8/7/2019

  #yehtetaung start 24/6/2019
  get '/signup', to:'users#new'
  post '/signup',to: 'users#create'
  #yehtetaung end 24/6/2019
 
  #yehtetaung start 25/6/2019
  post '/wscreate', to: 'workspace#create'
  get '/wscreate' , to: 'workspace#new'
  #yehtetaung end 25/6/2019
  
  #shinehtetnaung start 25/6/2019
  get '/managemember', to: 'channel#managemember'
  delete '/userremove', to: 'channel#userremove'
  #shinehtetnaung start 28/6/2019

  #Thinzarthein start 17/7/2019
  get '/managechannel', to: 'channel#managechannel'
  delete '/channeldelete', to: 'channel#channeldelete'
  #Thinzarthein end 17/7/2019
  
  #shinehtetnaung start 24/6/2019
  get '/channel', to: 'channel#new'
  post '/channel', to: 'channel#create'
  #shinehtetnaung end 25/6/2019
  
  #Thinzarthein start 26/6/2019
  get '/channelchat', to: 'channel#channelchat'
  get '/memberedit', to: 'channel#memberedit'
  get '/chmemberinvite', to: 'channel#chmemberinvite'
  get '/addchmember', to: 'channel#addchmember'
  delete '/channelremove',to: 'channel#channelremove'
  get '/chreplymsg', to: 'chmsgthread#chreplymsg'
  #Thinzarthein end 3/7/2019
  
  #Thinzarthein,SweZinMyat start 2/7/2019
  post '/chmessage' , to: 'channel#message'
  delete '/chmessagedelete', to:'channel#chmessagedelete'
  #Thinzarthein,SweZinMyat end 4/7/2019
  
  #Eishwezinhtun,yehtetaung  start 25/6/2019
  get '/mention', to: 'channel#mention'
  #Eishwezinhtun,yehtetaung end 12/7/2019
  
  #SweZinMyat start 5/7/2019
  get '/chmsgthread', to: 'chmsgthread#new'
  post '/chthreadinsert', to: 'chmsgthread#chthreadinsert'
  get  '/thread', to: 'threads#new'
  get '/dirmsgthread', to: 'dirmsgthread#new'
  post '/dirthreadinsert', to: 'dirmsgthread#dirthreadinsert'
  #SweZinMyat end 8/7/2019

  #Thinzarthein,SweZinMyat start 26/6/2019
  get  '/dirmsg',  to:'directmessage#new'
  post '/dirmsgcreate', to:'directmessage#create'
  delete '/messagedelete', to:'directmessage#messagedelete'
  #Thinzarthein,SweZinMyat start 1/7/2019

  #Thinzarthein start  10/7/2019
  get '/replymsg', to: 'dirmsgthread#replymsg'
  #Thinzarthein end 10/7/2019
  
  #SweZinMyat start 25/7/2019
  get '/dirmsgstar', to: 'dirmsgstar#new'
  delete '/dirmsgunstar', to: 'dirmsgstar#dirunstar'
  get '/chmsgstar', to: 'chmsgstar#new'
  delete '/chmsgunstar', to: 'chmsgstar#chunstar'
  get '/starmessage', to: 'static_pages#starmessage'
  get '/pubchannelshow', to: 'channel#pubchannelshow'
  get '/pubchmember', to: 'channel#pubchmember'
  #SweZinMyat start 16/7/2019

  #shinehtetnaung start 1/7/2019
  get '/invitations', to:'invitations#invitemember'
  post '/invitations', to:'invitations#create' 
  get '/invite', to: 'joinmembers#new'
  post '/invite', to: 'joinmembers#create' 
  #shinehtetnaung start 8/7/2019

  resources :invitations,only: [:create]
  resources :joinmembers
  
end
