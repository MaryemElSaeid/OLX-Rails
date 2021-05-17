class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :name])
    end
    
end



# private

# def sign_up_params
#  params.require(:user).permit(:name, :email, :password, :password_confirmation)
# end

# def account_update_params
#  params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
# end