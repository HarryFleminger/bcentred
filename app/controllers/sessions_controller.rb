class SessionsController < Devise::SessionsController

  protected

  def after_sign_in_path_for(resource)
    root_path # or whatever path you want
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path # or any other path you want to redirect to after sign out
  end
end
