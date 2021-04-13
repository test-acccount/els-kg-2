class OmniauthLocalizedController < ApplicationController
  skip_before_action :authenticate_user!

  def google_oauth2
    # Just save the current locale in the session and redirect to the unscoped path as before
    session[:omniauth_login_locale] = I18n.locale
    redirect_to user_google_oauth2_omniauth_authorize_path
  end
end
