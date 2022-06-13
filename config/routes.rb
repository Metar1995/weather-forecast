Rails.application.routes.draw do
  # get 'home/index'
  get 'postcode_wise_weather', to: 'home#postcode_wise_weather'
  root 'home#postcode_wise_weather'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
