Rails.application.routes.draw do
  #-----------------------------------------------------------------------------
  # Geojson services
  #-----------------------------------------------------------------------------
  namespace :geo_data do
    get 'interest_points' => 'interest_points#interest_points'
    get 'beach_walkway' => 'routes#beach_walkway'
  end

  #-----------------------------------------------------------------------------
  # Map page and route route
  #-----------------------------------------------------------------------------
  root 'home#index'
end
