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
      super
    else
      @user = resource
      if update_resource(@user, params[:user])
        flash[:notice] = 'Avatar successfully uploaded.'
        render :action => 'crop'
      else
        redirect_to root_path, alert: 'Your profile failed to save.'
      end
    end
  end
  
  def crop
    @user = User.find_by_name(params[:user][:name])
  end
  
  private
  
  def update_resource(resource, params)
    resource.update_with_password(params)
  end
end 