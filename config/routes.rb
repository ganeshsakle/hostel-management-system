Rails.application.routes.draw do
  resources :rooms do
    resources :bookings, only: [:create]
  end
  resources :rooms, only: [:destroy, :update]
  resources :hostels do
    resources :rooms, only: [:index, :create]
  end

  resources :bookings do
    member do
      put 'approve'
      put 'reject'
    end
  end

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end