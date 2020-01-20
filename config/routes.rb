Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'welcome#index'

  scope 'api/v1' do
    devise_for(
      :users,
      controllers: {
        confirmations: 'api/v1/users/confirmations',
        sessions: 'api/v1/users/sessions',
        invitations: 'api/v1/users/invitations'
      },
      defaults: { format: :json }
    )
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
    end
  end
end
