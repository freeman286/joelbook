class CustomFailure < Devise::FailureApp
  def redirect_url
    new_user_session_url(:subdomain => 'secure')
  end

  # Redirect to root_url
  def respond
    if http_auth?
      http_auth
    else
      store_location!
      flash[:alert] = i18n_message unless flash[:notice]
      puts "page=#{params[:user][:page]}"
      if params[:user][:page] == "sign up"
        redirect_to new_user_registration_path
      else
        redirect_to new_user_session_path
      end
    end
  end
end