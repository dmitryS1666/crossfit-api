RailsAdmin.config do |config|
  # config.authorize_with :pundit
  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0
  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration
  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard # mandatory
    index # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  RailsAdmin.config do |config|
    config.authorize_with do
      authenticate_or_request_with_http_basic(
        'Site Message'
      ) do |username, password|
        username == 'admin@mail.com' && password == 'DwRVdvIMRJ'
      end
    end

    config.main_app_name { ['My App', 'Admin'] }
  end

  config.model 'User' do
    list do
      field :id
      field :email
      field :reset_password_token
      field :reset_password_sent_at
      field :sign_in_count
      field :current_sign_in_at
      field :last_sign_in_at
      field :current_sign_in_ip
      field :last_sign_in_ip
      field :confirmation_token
      field :confirmed_at
      field :confirmation_sent_at
      field :unconfirmed_email
      field :created_at
      field :updated_at
      field :first_name
      field :last_name
      field :phone
      field :client
      field :trainer
      field :unp
      field :birthDate
      field :sex
      field :height
      field :weight
      field :duration
      field :visits
      field :price
      field :ticketId
      field :failed_attempts
      field :unlock_token
      field :locked_at
      field :superadmin_role
      field :user_role
    end
  end

  config.model 'Exercise' do
    list do
      field :id
      field :user_role
    end
  end

end
