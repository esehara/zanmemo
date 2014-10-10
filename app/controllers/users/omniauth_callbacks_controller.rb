class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    @user = User.find_or_create_by(user_params)
    
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
    else
      session["device.twitter_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  
  private
  def user_params
    auth = request.env["omniauth.auth"]
    user = auth.slice(:provider, :uid).to_h
    return user.merge({:trace_id => auth.info.nickname})
  end
end
