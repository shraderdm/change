Change::Application.routes.draw do
  get '*path', to: 'application#root'
  root to: 'application#root'
end
