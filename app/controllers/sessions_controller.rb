class SessionsController < Devise::SessionsController
  
  def create
	  resource = User.find_for_database_authentication(email: params[:user][:email])
	  return invalid_login_attempt unless resource

	  if resource.valid_password?(params[:user][:password])
	    self.resource = warden.authenticate!(auth_options)
	    #set_flash_message!(:notice, :signed_in)
	    sign_in(resource_name, resource)
     
	    yield resource if block_given?
	    respond_with resource, location: after_sign_in_path_for(resource)

	  else 
		invalid_login_attempt
	  end
  
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    #set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    respond_to_on_destroy
  end
 
  def after_sign_in_path_for(resource)
      root_path   
  end

  protected
  def invalid_login_attempt
#  set_flash_message(:alert, :invalid)
  render json: flash[:alert], status: 401
end


end