Rails.application.routes.draw do
  root 'link#new'
  get '/link', to: 'link#new', as: 'login'

  resources :oauth, only: [:new, :create]
  get '/oauth/deauth', to: 'oauth#deauth'
  get '/oauth2/callback', to: 'oauth#create'
  get '/examples', to: 'api/main#new', as: 'new_post'
  post '/post', to: 'api/main#create'
  get '/get', to: 'api/retrieve#show', as: 'get'

  #workouts
  get '/workouts/by_date', to: 'api/workouts#get_by_date'
  get '/workouts/athlete_by_date', to: 'api/workouts#get_athlete_by_date'
  get '/workouts/by_id', to: 'api/workouts#get_by_id'
  get '/workouts/athlete_by_id', to: 'api/workouts#get_athlete_by_id'
  get '/workouts/delete', to: 'api/workouts#delete_by_id'
  get '/workouts/meanmaxes', to: 'api/workouts#get_meanmaxes'
  get '/workouts/athlete_meanmaxes', to: 'api/workouts#get_athlete_meanmaxes'
  get '/workouts/details', to: 'api/workouts#get_details'
  get '/workouts/timeinzones', to: 'api/workouts#get_timeinzones'
  get '/workouts/athlete_timeinzones', to: 'api/workouts#get_athlete_timeinzones'
  get '/workouts/athlete', to: 'api/workouts#get_athlete'
  get '/workouts/since', to: 'api/workouts#get_since'
  get '/workouts/athlete_since', to: 'api/workouts#get_athlete_since'
  post '/workouts/plan', to: 'api/workouts#post_add'
  post '/workouts/update', to: 'api/workouts#post_update'

  #metrics
  get '/metrics/by_date', to: 'api/metrics#get_by_date'
  get '/metrics/athlete_by_date', to: 'api/metrics#get_athlete_by_date'
  post '/metrics/add', to: 'api/metrics#post_add'

  #files
  post '/files/add', to: 'api/files#post_add'

  #events
  get '/events/by_date', to: 'api/events#get_by_date'
  get '/events/next', to: 'api/events#get_next_event'
  post '/events/add', to: 'api/events#post_add'

  #wod
  get '/wod/file', to: 'api/workout_of_the_day#get_file'
  get '/wod/get', to: 'api/workout_of_the_day#get_wod'
  get '/wod/get_multiple', to: 'api/workout_of_the_day#get_wod_multiple'

  #athletes
  get '/athlete/profile', to: 'api/athlete#get_profile'
  get '/athlete/zones', to: 'api/athlete#get_zones'
  get '/athlete/zones_by_type', to: 'api/athlete#get_zones_by_type'

  #coaches
  get '/coach/athletes', to: 'api/coach#get_athletes'
  get '/coach/athlete_zones', to: 'api/coach#get_zones_for_athlete'
  get '/coach/athlete_zones_by_type', to: 'api/coach#get_zones_by_type_for_athlete'
  get '/coach/profile', to: 'api/coach#get_coach_profile'
  get '/coach/assistants', to: 'api/coach#get_assistant_coaches'
  get '/coach/assistants_by_id', to: 'api/coach#get_assistant_coach'
  get '/coach/assistants_athletes', to: 'api/coach#get_assistant_coach_athletes'
end