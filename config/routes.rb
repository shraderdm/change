Change::Application.routes.draw do

  post 'score', to: 'scores#add_score', as: 'add_score'

  get '*path', to: 'application#root'
  root to: 'application#root'
end
