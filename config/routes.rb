# frozen_string_literal: true

# rubocop:disable Layout/LineLength
# == Route Map
#
#                                Prefix Verb   URI Pattern                                                                              Controller#Action
#                                  root GET    /                                                                                        welcome#index
#                      new_user_session GET    /api/v1/users/sign_in(.:format)                                                          api/v1/users/sessions#new {:format=>:json}
#                          user_session POST   /api/v1/users/sign_in(.:format)                                                          api/v1/users/sessions#create {:format=>:json}
#                  destroy_user_session DELETE /api/v1/users/sign_out(.:format)                                                         api/v1/users/sessions#destroy {:format=>:json}
#                     new_user_password GET    /api/v1/users/password/new(.:format)                                                     api/v1/users/passwords#new {:format=>:json}
#                    edit_user_password GET    /api/v1/users/password/edit(.:format)                                                    api/v1/users/passwords#edit {:format=>:json}
#                         user_password PATCH  /api/v1/users/password(.:format)                                                         api/v1/users/passwords#update {:format=>:json}
#                                       PUT    /api/v1/users/password(.:format)                                                         api/v1/users/passwords#update {:format=>:json}
#                                       POST   /api/v1/users/password(.:format)                                                         api/v1/users/passwords#create {:format=>:json}
#              cancel_user_registration GET    /api/v1/users/cancel(.:format)                                                           api/v1/users/registrations#cancel {:format=>:json}
#                 new_user_registration GET    /api/v1/users/sign_up(.:format)                                                          api/v1/users/registrations#new {:format=>:json}
#                edit_user_registration GET    /api/v1/users/edit(.:format)                                                             api/v1/users/registrations#edit {:format=>:json}
#                     user_registration PATCH  /api/v1/users(.:format)                                                                  api/v1/users/registrations#update {:format=>:json}
#                                       PUT    /api/v1/users(.:format)                                                                  api/v1/users/registrations#update {:format=>:json}
#                                       DELETE /api/v1/users(.:format)                                                                  api/v1/users/registrations#destroy {:format=>:json}
#                                       POST   /api/v1/users(.:format)                                                                  api/v1/users/registrations#create {:format=>:json}
#                 new_user_confirmation GET    /api/v1/users/confirmation/new(.:format)                                                 api/v1/users/confirmations#new {:format=>:json}
#                     user_confirmation GET    /api/v1/users/confirmation(.:format)                                                     api/v1/users/confirmations#show {:format=>:json}
#                                       POST   /api/v1/users/confirmation(.:format)                                                     api/v1/users/confirmations#create {:format=>:json}
#                       new_user_unlock GET    /api/v1/users/unlock/new(.:format)                                                       api/v1/users/unlocks#new {:format=>:json}
#                           user_unlock GET    /api/v1/users/unlock(.:format)                                                           api/v1/users/unlocks#show {:format=>:json}
#                                       POST   /api/v1/users/unlock(.:format)                                                           api/v1/users/unlocks#create {:format=>:json}
#                accept_user_invitation GET    /api/v1/users/invitation/accept(.:format)                                                api/v1/users/invitations#edit {:format=>:json}
#                remove_user_invitation GET    /api/v1/users/invitation/remove(.:format)                                                api/v1/users/invitations#destroy {:format=>:json}
#                   new_user_invitation GET    /api/v1/users/invitation/new(.:format)                                                   api/v1/users/invitations#new {:format=>:json}
#                       user_invitation PATCH  /api/v1/users/invitation(.:format)                                                       api/v1/users/invitations#update {:format=>:json}
#                                       PUT    /api/v1/users/invitation(.:format)                                                       api/v1/users/invitations#update {:format=>:json}
#                                       POST   /api/v1/users/invitation(.:format)                                                       api/v1/users/invitations#create {:format=>:json}
#                          api_v1_roles GET    /api/v1/roles(.:format)                                                                  api/v1/roles#index {:format=>:json}
#                                       POST   /api/v1/roles(.:format)                                                                  api/v1/roles#create {:format=>:json}
#                           api_v1_role GET    /api/v1/roles/:id(.:format)                                                              api/v1/roles#show {:format=>:json}
#                                       PATCH  /api/v1/roles/:id(.:format)                                                              api/v1/roles#update {:format=>:json}
#                                       PUT    /api/v1/roles/:id(.:format)                                                              api/v1/roles#update {:format=>:json}
#                                       DELETE /api/v1/roles/:id(.:format)                                                              api/v1/roles#destroy {:format=>:json}
#         rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#create
#         rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                  action_mailbox/ingresses/postmark/inbound_emails#create
#            rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                     action_mailbox/ingresses/relay/inbound_emails#create
#         rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                  action_mailbox/ingresses/sendgrid/inbound_emails#create
#          rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                              action_mailbox/ingresses/mailgun/inbound_emails#create
#        rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#index
#                                       POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#create
#         rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#show
#                                       PATCH  /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       PUT    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       DELETE /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#destroy
# rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                      rails/conductor/action_mailbox/reroutes#create
#                    rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#             rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#                    rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#             update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#                  rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
# rubocop:enable Layout/LineLength

Rails.application.routes.draw do
  root to: 'welcome#index'

  scope 'api/v1' do
    devise_for(
      :users,
      controllers: {
        confirmations: 'api/v1/users/confirmations',
        sessions: 'api/v1/users/sessions',
        invitations: 'api/v1/users/invitations',
        omniauths: 'api/v1/users/omniauths',
        passwords: 'api/v1/users/passwords',
        registrations: 'api/v1/users/registrations',
        unlocks: 'api/v1/users/unlocks'
      },
      defaults: { format: :json }
    )
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      concern :attachable do
        resources :attachments
      end

      concern :imageable do
        resources :photos
      end

      concern :clipable do
        resources :videos
      end

      concern :itemable do
        resources :line_items
      end

      resources :profiles, concerns: :imageable
      resources :roles
      resources :users do
        collection do
          get :profile
        end
        resources :settings, shallow: true
      end
      resources :settings, only: :index
      resources :regions, shallow: true do
        resources :districts do
          resources :extensions
        end
      end
      resources :districts, only: :index
      resources :extensions, only: :index
      resources :product_types, shallow: true do
        resources :products
      end
      resources :products, only: :index
      resources :stocks
      resources :indents, concerns: :itemable, shallow: true
      resources :units
      resources :agencies
    end
  end
end
