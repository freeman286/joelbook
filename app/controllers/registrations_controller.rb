class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    if params[:user][:avatar].blank?
      super
    else
      @user = resource
      if @user.save
        flash[:notice] = 'Avatar successfully uploaded.'
        render :action => 'crop'
      else
        redirect_to root_path, alert: 'Your user failed to save.'
      end
    end
  end

  def update
    if params[:user][:avatar].blank?
      account_update_params = params[:user]
      if account_update_params[:password].blank?
        account_update_params.delete("password")
        account_update_params.delete("password_confirmation")
      end

      @user = User.find(current_user.id)
      if @user.update_attributes(account_update_params)
        set_flash_message :notice, :updated
        sign_in @user, :bypass => true
        redirect_to after_update_path_for(@user)
      else
        render "edit"
      end
    else
      @user = User.find(current_user.id)
      @user.avatar = Pathname.new(params[:user][:avatar].open.path) 
      if @user.update_attributes(account_update_params)
        flash[:notice] = 'Avatar successfully uploaded.'
        render :action => 'crop'
      else
        redirect_to root_path, alert: 'Your profile failed to save.'
      end
    end
  end
  
  def crop
    @user = current_user
  end
  
  private
  
  def update_resource(resource, params)
    resource.update_with_password(params)
  end
  
  protected

  def after_sign_up_path_for(resource)
    '/channels'
  end
end 