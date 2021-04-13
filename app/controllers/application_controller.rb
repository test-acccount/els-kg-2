class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :authenticate_user!
  before_action :redirect_to_passport_setup?, unless: :devise_controller?

  def default_url_options
    { locale: I18n.locale }
  end

  private
    def set_locale
      I18n.locale = current_user.try(:locale) || params[:locale] || I18n.default_locale
    end

    def redirect_to_passport_setup?
      if user_signed_in?
        unless current_user.passport || current_user.admin? || current_user.super_admin?
          redirect_to new_passport_url
        end
      end
    end
end
