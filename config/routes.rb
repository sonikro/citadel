Rails.application.routes.draw do
  root 'pages#home'

  get 'pages/home'

  get 'admin', to: 'admin#index'

  namespace :meta do
    resources :games, except: [:destroy]
    resources :formats, except: [:destroy]
    resources :maps, except: [:destroy]
  end

  patch 'leagues/:id/visibility', to: 'leagues#visibility', as: 'league_visibility'
  resources :leagues do
    resources :rosters, controller: 'leagues/rosters', except: [:destroy]
    resources :matches, controller: 'leagues/matches', except: [:destroy]
  end

  get   'teams/:id/recruit', to: 'teams#recruit', as: 'recruit_team'
  patch 'teams/:id/invite',  to: 'teams#invite',  as: 'invite_team'
  patch 'teams/:id/leave',   to: 'teams#leave',   as: 'leave_team'
  patch 'teams/:id/grant',   to: 'teams#grant',   as: 'grant_team'
  patch 'teams/:id/revoke',  to: 'teams#revoke',  as: 'revoke_team'
  resources :teams, except: [:destroy]

  patch 'team_invites/:id/accept',  to: 'team_invites#accept',  as: 'accept_team_invite'
  patch 'team_invites/:id/decline', to: 'team_invites#decline', as: 'decline_team_invite'

  # Debug
  patch 'users/grant_meta', to: 'users#grant_meta', as: 'grant_meta'
  patch 'users/revoke_meta', to: 'users#revoke_meta', as: 'revoke_meta'

  get 'users/logout', to: 'users#logout', as: 'logout_user'
  resources :users, except: [:destroy]

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
