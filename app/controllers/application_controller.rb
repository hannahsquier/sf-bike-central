class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  private

  NEIGHBORHOODS = ["Castro District", "Chinatown", "Cole Valley", "Financial District", "Fisherman's Wharf", "Haight Ashbury", "Hayes Valley"," Japantown", "Lower Haight", "Marina", "Mission District", "Nob Hill", "Noe Valley", "North Beach", "Pacific Heights", "Panhandle", "Potrero Hill", "Presidio", "Richmond"," Russian Hill", "Sea Cliff","SOMA", "Sunset", "Tenderloin", "Union Square", "Upper Market"]

  def sign_in(user)
    user.regenerate_auth_token
    cookies[:auth_token] = user.auth_token
    @current_user = user
  end

  # new wrinkle for permanent sign-in
  # uses `cookies.permanent` instead of just `cookies`
  def permanent_sign_in(user)
    user.regenerate_auth_token
    cookies.permanent[:auth_token] = user.auth_token
    @current_user = user
  end

  # cookies!
  def sign_out
    @current_user = nil
    cookies.delete(:auth_token)
  end

  # cookies!
  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user


  def require_login
    unless current_user
      flash[:error] = "Not authorized, please sign in!"
      redirect_to root_path
    end
  end


  
  def user_is_current_user?
    unless params[:id].to_i == current_user.id
      flash[:error] = "Not authorized!"
      redirect_to user_posts_path(current_user.id)
    end
  end
end
