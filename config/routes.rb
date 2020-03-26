Rails.application.routes.draw do
  root 'shelters#index'
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show', as: 'shelters_show'

  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'

  post '/shelters', to: 'shelters#create'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index', as: 'pets_index'
  get '/pets/:pet_id', to: 'pets#show', as: 'pets_show'

  get '/shelters/:id/pets', to: 'shelters#pet_index'

  get '/shelters/:id/pets/new', to: 'pets#new'
  post '/shelters/:id/pets', to: 'pets#create'

  get '/pets/:pet_id/edit', to: 'pets#edit'
  patch '/pets/:pet_id', to: 'pets#update'

  delete '/pets/:id', to: 'pets#destroy'

  get '/shelters/:id/reviews/new', to: 'shelter_reviews#new', as: 'shelter_reviews_new'
  post '/shelters/:id/reviews', to: 'shelter_reviews#create', as: 'shelter_reviews_create'

  get '/reviews/:review_id/edit', to: 'shelter_reviews#edit', as: 'shelter_reviews_edit'
  patch '/reviews/:review_id', to: 'shelter_reviews#update', as: 'shelter_reviews_update'

  delete '/reviews/:review_id', to: 'shelter_reviews#destroy', as: 'shelter_reviews_destroy'

end
