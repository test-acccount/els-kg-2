module Admin
  class SiteSettingsController < AdminController
    before_action -> { @site_setting = SiteSetting.first }, only: [:edit, :update]

    def edit
    end

    def update
      if @site_setting.update(site_settings_params)
        redirect_to admin_root_path, notice: t(".notice")
      else
        render :edit
      end
    end

    private
      def site_settings_params
        params.require(:site_setting).permit(:domain, :site_name, :site_name_short, :country, :country_code, :contact_phone_numbers)
      end
  end
end
