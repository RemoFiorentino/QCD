RailsAdmin.config do |config|
  config.authorize_with do
    redirect_to main_app.root_path unless current_user.admin?
  end
  config.included_models = ["User", "Qcd", "Asignatura"]
  
  config.model 'User' do
    label "Usuario" 
    label_plural "Usuarios"
    list do
      field :name do
        label "Nombre"
      end
      include_all_fields
      exclude_fields :id, :created_at, :updated_at, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :provider, :uid, :password, :password_confirmation, :asignaturas
    end
    edit do
      field :name do
        label "Nombre"
      end
      include_all_fields
      exclude_fields :id, :created_at, :updated_at, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :provider, :uid, :password, :password_confirmation, :asignaturas
    end
    show do
      field :name do
        label "Nombre"
      end
      include_all_fields
      exclude_fields :id, :created_at, :updated_at, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :provider, :uid, :password, :password_confirmation, :asignaturas
    end
  end
  config.model 'Qcd' do
    configure :informe do
      formatted_value do
        util = bindings[:object]
        %{<a href="/asignaturas/#{util.asignatura_id}/qcds/#{util.id}">informe</a>}.html_safe
      end
      pretty_value do
        util = bindings[:object]
        %{<a href="/asignaturas/#{util.asignatura_id}/qcds/#{util.id}">informe</a>}.html_safe
      end
      children_fields [:asignatura_id, :id] 
      read_only true 
    end
    list do
      include_all_fields
      exclude_fields :id, :created_at, :updated_at, :grupo
    end
    edit do
      include_all_fields
      exclude_fields :id, :created_at, :updated_at, :grupo
    end
    show do
      include_all_fields
      exclude_fields :id, :created_at, :updated_at, :grupo
    end
  end
  config.model 'Asignatura' do
    config.label_methods << :nombre # Default is [:name, :title]
    list do
      include_all_fields
      field :dpto do
        label "Departamento"
      end
      exclude_fields :id, :created_at, :updated_at, :creditos, :objetivo1, :objetivo2, :objetivo3, :objetivo4, :objetivo5, :objetivo6, :objetivo7, :objetivo8, :objetivo9, :objetivo10
    end
    edit do
      include_all_fields
      field :dpto do
        label "Departamento"
      end

      exclude_fields :id, :created_at, :updated_at
    end
    show do
      include_all_fields
      field :dpto do
        label "Departamento"
      end
      
      exclude_fields :id, :created_at, :updated_at
    end
  end
  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true

  config.actions do
    dashboard do
      statistics false
    end                 
    index                         # mandatory
    bulk_delete
    show
    edit
    delete

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
