Rails.application.routes.draw do
  root 'shelters#index'
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:shelter_id', to: 'shelters#show'

  get '/shelters/:shelter_id/edit', to: 'shelters#edit'
  patch '/shelters/:shelter_id', to: 'shelters#update'

  post '/shelters', to: 'shelters#create'
  delete '/shelters/:shelter_id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
  get '/pets/:pet_id', to: 'pets#show'

  get '/shelters/:shelter_id/pets', to: 'shelters#pet_index'

  get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  post '/shelters/:shelter_id/pets', to: 'pets#create'

  get '/pets/:pet_id/edit', to: 'pets#edit'
  patch '/pets/:pet_id', to: 'pets#update'

  delete '/pets/:pet_id', to: 'pets#destroy'

  get '/shelters/:shelter_id/reviews/new', to: 'shelter_reviews#new'
  post '/shelters/:shelter_id/reviews', to: 'shelter_reviews#create'

  get '/reviews/:review_id/edit', to: 'shelter_reviews#edit'
  patch '/reviews/:review_id', to: 'shelter_reviews#update'

  delete '/reviews/:review_id', to: 'shelter_reviews#destroy'

  patch '/favorites/:pet_id', to: 'favorite#update'
  delete '/favorites/:pet_id', to: 'favorite#destroy'
  delete '/favorites', to: 'favorite#destroy_all'

  get '/favorites', to: 'favorite#index'
  get '/pet_applications/new', to: 'pet_applications#new'
  post '/pet_applications/', to: 'pet_applications#create'

  get '/pet_applications/:application_id', to: 'pet_applications#show'
  get '/pets/:pet_id/applications', to: 'pet_applications#index'

  patch '/pet_applications/:application_id/:pet_id', to: 'pet_applications#approve'
end
