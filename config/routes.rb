Rails.application.routes.draw do
  root 'shelters#index'

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'

  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'

  post '/shelters', to: 'shelters#create'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
  get '/pets/:pet_id', to: 'pets#show'

  get '/shelters/:id/pets', to: 'shelters#pet_index'

  get '/shelters/:id/pets/new', to: 'pets#new'
  post '/shelters/:id/pets', to: 'pets#create'

  get '/pets/:pet_id/edit', to: 'pets#edit'
  patch '/pets/:pet_id', to: 'pets#update'

  delete '/pets/:id', to: 'pets#destroy'

end
