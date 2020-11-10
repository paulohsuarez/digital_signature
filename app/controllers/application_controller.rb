class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
      render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
  end

  def after_sign_in_path_for(resource)
    if resource_name == :user
 	"/controle/home"
    elsif  resource_name == :admin
 	 "/administration"
    end
  end

  
end
